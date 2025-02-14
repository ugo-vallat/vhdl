--------------------------------------------------------------------------------
-- FIFO double port
-- F.Thiebolt
--------------------------------------------------------------------------------

-- Definition des librairies
library IEEE;

-- Definition des portee d'utilisation
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;

-- -----------------------------------------------------------------------------
-- Definition de l'entite
-- -----------------------------------------------------------------------------
entity fifo is

	-- definition des parametres generiques
	generic	(
		-- largeur du bus de donnees
		DBUS_WIDTH : natural := 32;

		-- largeur du bus adr R/W pour acces fifo
		ABUS_WIDTH : natural := 5 );	-- soit 2**3 emplacements

	-- definition des entrees/sorties
	port 	(
		-- signaux de controle de la FIFO
		CLK,RST	: in std_logic;	-- RST is active low
		REN,WEN	: in std_logic;	-- Read & Write Enable are actives low

		-- bus de donnees en entree
		DI	: in std_logic_vector(DBUS_WIDTH-1 downto 0);

		-- bus de donnees en sortie
		DO	: out std_logic_vector(DBUS_WIDTH-1 downto 0);

		-- indicateurs d'etat
		EMPTY,MID,FULL	: buffer std_logic );

end fifo;

-- -----------------------------------------------------------------------------
-- Definition de l'architecture de la fifo
-- -----------------------------------------------------------------------------
architecture behavior of fifo is

	-- definitions de types (index type default is integer)
	type FILE_REG_typ is array (0 to (2**ABUS_WIDTH)-1) of std_logic_vector (DBUS_WIDTH-1 downto 0);

	-- definition des ressources internes

	-- registres
	signal REGS : FILE_REG_typ; -- le banc de registres interne de la fifo

	-- pointeurs lecture et ecriture
	signal W_ADR,R_ADR	: std_logic_vector (ABUS_WIDTH-1 downto 0);

begin

------------------------------------------------------------------
-- Mise a jour des sorties dans le domaine concourant

----------------------------------------------------------------------------
-- Process P_WRITE effectue l'ecriture de la donnee dans la file ainsi que
--		la mise a jour du pointeur d'adresse ecriture.
--		Le pointeur pointe toujours sur l'emplacement de la prochaine ecriture.
P_WRITE:	process(CLK)
begin
	if rising_edge(CLK) then
		-- test du RST
		if RST='0' then
		  W_ADR <= (others => '0');
		elsif WEN = '0' then
		  W_ADR <= W_ADR + '1';
		  REGS(conv_integer(W_ADR)) <= DI;
		end if;
	end if;
end process P_WRITE;

---------------------------------------------------------------------------
-- Process P_READ sort la donnee sur le bus et effectue la mise a jour
--		du pointeur d'adresse lecture.
--		Le pointeur pointe toujours sur l'emplacement de la prochaine lecture
P_READ:	process(CLK)
begin
	if rising_edge(CLK) then
		-- test du RST
		if RST='0' then
			R_ADR <= (others => '0');
			DO <=  (others => 'Z');
		else 
		  if REN = '0' then
		      if EMPTY = '0' then
		          R_ADR <= R_ADR + '1';
                  DO <= REGS(conv_integer(R_ADR));
              else
                DO <=(others => '0');
              end if;
		  else
            if WEN = '0' and EMPTY = '0' then
               if W_ADR = R_ADR then
                  R_ADR <= R_ADR + '1';
               end if;
            end if;
          end if;
		end if;
	end if;
end process P_READ;

-------------------------------------------------------------------------
-- Process P_EMPTY indique '1' la FIFO est vide '0' sinon, cette information
--		 etant mise a jour sur front montant d'horloge
P_EMPTY:	process(CLK)
	variable next_R : std_logic_vector (ABUS_WIDTH-1 downto 0);
begin
	if rising_edge(CLK) then
		-- test du RST
		if RST='0' then
			EMPTY <= '1';
        elsif EMPTY = '0' then
          if WEN = '1' and REN = '0' and W_ADR = (R_ADR + '1') then
            EMPTY <= '1';
          end if;
        else
		    if WEN = '0' then
		       EMPTY <= '0';
		    end if;  
		end if;
	end if;
end process P_EMPTY;

---------------------------------------------------------------------------
-- Process P_FULL indique '1' la FIFO est pleine '0' sinon, cette information
--		 etant mise a jour sur front montant d'horloge
P_FULL: process(CLK)
	variable next_W : std_logic_vector (ABUS_WIDTH-1 downto 0);
begin
	if rising_edge(CLK) then
		-- test du RST
		if RST='0' then
            FULL <= '0';
        else
            if FULL = '0' then
                if EMPTY = '0' and WEN = '0' and REN = '1' then
                    if R_ADR = (W_ADR + '1') then
                        FULL <= '1';
                    end if;
                end if;
            else
                if WEN = '1' and REN = '0' then
                    FULL <= '0';
                end if;
            end if;
		end if;
	end if;
end process P_FULL;

--------------------------------------------------------------------
-- Process P_MID indique l'etat au moins a moitie plein de la FIFO
--		'1' FIFO au moins a moitie pleine '0' sinon, cette information
--		 etant mise a jour sur front montant d'horloge
P_MID:	process(CLK)
	variable temp_W : std_logic_vector (ABUS_WIDTH-1 downto 0);
begin
	if rising_edge(CLK) then
		-- test du RST
		if RST='0' then
            MID <= '0';
        else
            temp_W := W_ADR + '1';
            if REN /= WEN then
                if WEN = '0' then 
                    if R_ADR[R_ADR'high] /= temp_W[W_ADR'high] and R_ADR[R_ADR'high-1 downto 0] = temp_W[W_ADR'high-1 downto 0] then
                        MID <= '1';
                    end if;
                else
                    if R_ADR[R_ADR'high] == W_ADR[W_ADR'high] or R_ADR[R_ADR'high-1 downto 0] >= W_ADR[W_ADR'high-1 downto 0] then
                        MID <= '0';
                    end if;
                end if;
            end if;
		end if;
	end if;
end process P_MID;

end behavior;

