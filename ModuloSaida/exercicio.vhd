--BANCO REGISTRADORES

library ieee;
use ieee.std_logic_1164.all;

entity modsaida is
	port ( 
		clk, op_over, reset, erro_ula: in std_logic;
		result: in std_logic_vector (15 downto 0);
		led_op_over, led_doing_op , led_reset, led_erro_ula: out std_logic;
		displays: out std_logic_vector (15 downto 0)

	);
end;

architecture modsaida of modsaida is
begin
	process (clk)
	begin
		if (clk'event and clk = '1') then
			if ( reset = '1' ) then
				led_reset <= '1';
				led_erro_ula <= '0';
				led_op_over <= '0';
				displays <= "0000000000000000";
				led_doing_op <= '1';
			elsif (op_over = '1') then
				led_op_over <= '1';
				led_doing_op <= '0';
				led_reset <= '0';
			elsif (op_over = '0') then
				led_op_over <= '0';
				led_doing_op <= '1';
				displays <= result;
				led_erro_ula <= erro_ula;
			end if;
		end if;
	end process;
end modsaida;
