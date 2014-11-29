-----------------------------------------------------------------------
-------------------------------FSM-------------------------------------
-----------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
entity entry IS
port ( clk, clr, valid, do_operation: in std_logic;
		switches: in std_logic_vector(15 downto 0);
		save_instru, do_next_instru, reset: out std_logic;
		instru: out std_logic_vector (15 downto 0);
		state: out std_logic_vector (1 downto 0);
		clkout: out std_logic
);
end entry;

architecture entry_fsm of entry is
	constant STWAIT: std_logic_vector (1 downto 0) := "00";
	constant STRESET: std_logic_vector (1 downto 0) := "01";
	constant STSAVE: std_logic_vector (1 downto 0) := "10";
	constant STDOOP: std_logic_vector (1 downto 0) := "11";
	signal st: std_logic_vector (1 downto 0) := STRESET;
begin
	PROCESS (clk)
	BEGIN
		if (clk'event and clk = '1') then
			case st is
				when STWAIT =>
					if (clr'event and clr = '1') then
						--wait for 10 ps; --espera e verifica se sinal estabilizou
						st <= STRESET;
					elsif (valid'event and valid = '1') then
						--wait for 10 ps; --espera e verifica se sinal estabilizou
						st <= STSAVE;
					elsif (do_operation'event and do_operation = '1') then
						--wait for 10 ps; --espera e verifica se sinal estabilizou
						st <= STDOOP;
					end if;
				when STRESET =>
					if (clr'event and clr = '0') then
						--wait for 10 ps; --espera e verifica se sinal estabilizou
						st <= STWAIT;
					end if;
				when STDOOP =>
					if (do_operation'event and do_operation = '0') then
						--wait for 10 ps; --espera e verifica se sinal estabilizou
						st <= STWAIT;
					end if;
				when STSAVE =>
					if (valid'event and valid = '0') then
						--wait for 10 ps; --espera e verifica se sinal estabilizou
						st <= STWAIT;
					end if;
				when others =>
					st <= STWAIT;
			end case;
		end if;

--		if (st = STWAIT) then
--			save_instru <= '0';
--			do_next_instru <= '0';
--			reset <= '0';
--		elsif (st = STRESET) then
--			reset <= '1';
--		elsif (st = STDOOP) then
--			do_next_instru <= '1';
--		elsif (st = STSAVE) then
--			save_instru <= '1';
--			instru <= switches;
--		end if;
--		state <= st;
	end process;

	reset <= '1' when st = STRESET else '0';
	save_instru <= '1' when st = STSAVE else '0';
	do_next_instru <= '1' when st = STDOOP else '0';
	instru <= "0000000000000000" when st = STRESET else switches when st = STSAVE;
	state <= st;
	clkout <= clk;
end entry_fsm;
