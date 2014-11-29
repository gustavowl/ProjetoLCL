library ieee;
use ieee.std_logic_1164.all;

entity ram_tb is
end ram_tb;

architecture ram_tb of ram_tb is
	signal sclk, swren: std_logic;
	signal send, sin, sout: std_logic_vector(15 downto 0);
	
begin
	vector: entity work.ram
	port map (
		clock => sclk,
		wren => swren,
		addr => send,
		data_i => sin,
		data_o => sout
	);
end ram_tb;
