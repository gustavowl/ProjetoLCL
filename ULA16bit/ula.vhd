-----------------------------------------------------------------------
-----------------------------DESLOCADOR--------------------------------
-----------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

entity deslocador is
	port (
		a: in std_logic_vector(15 downto 0);
		desl: in std_logic; --desloca
		lado: in std_logic; --0 divide 1 multiplica
		c: out std_logic_vector(15 downto 0);
		cout: out std_logic
	);
end deslocador;

architecture deslocador of deslocador is
begin
	c <= a(15 downto 0) when desl = '0' else
		'0' & a(15 downto 1) when lado = '0' else
		a(14 downto 0) & '0';
	cout <= a(15) when lado = '1' and desl = '1' else '0';
end deslocador;

-----------------------------------------------------------------------
--------------------------------MUX A----------------------------------
-----------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

entity Mux8x1A is
	port (
		a: in std_logic_vector(15 downto 0);
		b: in std_logic_vector(15 downto 0);
		x: in std_logic;
		y: in std_logic;
		z: in std_logic;
		c: out std_logic_vector(15 downto 0);
		cout: out std_logic
	);
end Mux8x1A;

architecture Mux8x1A of Mux8x1A is
	component deslocador
	port (
		a: in std_logic_vector(15 downto 0);
		desl: in std_logic; --desloca
		lado: in std_logic; --0 divide 1 multiplica
		c: out std_logic_vector(15 downto 0);
		cout: out std_logic
	);
	end component;

	signal temp: std_logic_vector (15 downto 0);
	signal txy, tz: std_logic;
begin
	temp <= a when x = '0' else
		a and b when y = '0' and z = '0' else
		a or b when y = '0' and z = '1' else
		a nor b when y = '1' and z = '0' else
		not a;
	txy <= (not x) and y;
	tz <= not z;
	desloc: deslocador port map (temp, txy, tz, c, cout);
end Mux8x1A;

-----------------------------------------------------------------------
--------------------------------MUX B----------------------------------
-----------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

entity Mux8x1B is
	port (
		a: in std_logic_vector(15 downto 0);
		x: in std_logic;
		y: in std_logic;
		z: in std_logic;
		c: out std_logic_vector(15 downto 0)
	);
end Mux8x1B;

architecture Mux8x1B of Mux8x1B is
begin
	c <= "0000000000000000" when (x = '1' or y = '1') else
		a when z = '0' else not a;
end Mux8x1B;

-----------------------------------------------------------------------
--------------------------------MUX C----------------------------------
---------------------------comparador----------------------------------
--Identifica se está fazendo subtração para CIN p/ conversão em complemento de 2

library ieee;
use ieee.std_logic_1164.all;

entity Mux8x1C is
	port (
		x: in std_logic;
		y: in std_logic;
		z: in std_logic;
		c: out std_logic
	);
end Mux8x1C;

architecture Mux8x1C of Mux8x1C is
begin
	c <= '1' when (x = '0' and y = '0' and z = '1') else '0';-- or
--		(x = '1' and y = '1' and z = '0') else '0';
		
end Mux8x1C;

-----------------------------------------------------------------------
---------------------------COMPONENTE LÓGICO---------------------------
-----------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

entity CompLog is
	port (
		a: in std_logic_vector(15 downto 0);
		b: in std_logic_vector(15 downto 0);
		x, y, z: in std_logic;
		ia: out std_logic_vector(15 downto 0);
		ib: out std_logic_vector(15 downto 0);
		Cin: out std_logic; --p/ conversão em complemento de 2
		Cout: out std_logic --p/ identificar overflow na multiplicação
	);
end CompLog;

architecture CompLog of CompLog is
	component Mux8x1A
	port (
		a: in std_logic_vector(15 downto 0);
		b: in std_logic_vector(15 downto 0);
		x: in std_logic;
		y: in std_logic;
		z: in std_logic;
		c: out std_logic_vector(15 downto 0);
		cout: out std_logic
	);
	end component;

	component Mux8x1B
	port (
		a: in std_logic_vector(15 downto 0);
		x: in std_logic;
		y: in std_logic;
		z: in std_logic;
		c: out std_logic_vector(15 downto 0)
	);
	end component;

	component Mux8x1C
	port (
		x: in std_logic;
		y: in std_logic;
		z: in std_logic;
		c: out std_logic
	);
	end component;
begin
	mux8x1a0: Mux8x1A port map (a, b, x, y, z, ia, Cout);
--	ia <= "01001001";
	mux8x1b0: Mux8x1B port map (b, x, y, z, ib);
	mux8x1c0: Mux8x1C port map (x, y, z, Cin);
end CompLog;

-----------------------------------------------------------------------
--------------------------SOMADOR 1 BIT--------------------------------
-----------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

entity somador1bit is
	port (
		a: in std_logic;
		b: in std_logic;
		cin: in std_logic;
		s: out std_logic;
		cout: out std_logic
	);
end somador1bit;

architecture somador1bit of somador1bit is
begin
	cout <= (cin and a) or (cin and b) or (a and b);
	s <= (not cin and not a and b) or (not cin and a and not b)
		or (cin and not a and not b) or (cin and a and b);
end somador1bit;


-----------------------------------------------------------------------
--------------------------SOMADOR 16 BITS-------------------------------
-----------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

entity somador16bits is
	port (
		a: in std_logic_vector(15 downto 0);
		b: in std_logic_vector(15 downto 0);
		cin: in std_logic;
		s: out std_logic_vector(15 downto 0);
		cout: out std_logic
	);
end somador16bits;

architecture somador16bits of somador16bits is
	component somador1bit
	port (
		a, b, cin: in std_logic;
		s, cout: out std_logic
	);
	end component;

	signal ta, tb, ts: std_logic_vector(15 downto 0);
	signal c0, c1, c2, c3, c4, c5, c6, c7, c8, c9, c10, c11, c12, c13, c14, c15: std_logic;
begin
	ta <= a;
	tb <= b;
	s8b0: somador1bit port map (a(0), b(0), cin, ts(0), c0);
	s8v1: somador1bit port map (a(1), b(1), c0, ts(1), c1);
	s8v2: somador1bit port map (a(2), b(2), c1, ts(2), c2);
	s8v3: somador1bit port map (a(3), b(3), c2, ts(3), c3);
	s8v4: somador1bit port map (a(4), b(4), c3, ts(4), c4);
	s8v5: somador1bit port map (a(5), b(5), c4, ts(5), c5);
	s8v6: somador1bit port map (a(6), b(6), c5, ts(6), c6);
	s8v7: somador1bit port map (a(7), b(7), c6, ts(7), c7);
	s8b8: somador1bit port map (a(8), b(8), c7, ts(8), c8);
	s8v9: somador1bit port map (a(9), b(9), c8, ts(9), c9);
	s8v10: somador1bit port map (a(10), b(10), c9, ts(10), c10);
	s8v11: somador1bit port map (a(11), b(11), c10, ts(11), c11);
	s8v12: somador1bit port map (a(12), b(12), c11, ts(12), c12);
	s8v13: somador1bit port map (a(13), b(13), c12, ts(13), c13);
	s8v14: somador1bit port map (a(14), b(14), c13, ts(14), c14);
	s8v15: somador1bit port map (a(15), b(15), c14, ts(15), c15);
	--verifica overflow e underflow
	cout <= (not a(15) and not b(15) and ts(15)) or (a(15) and b(15) and not ts(15));
	s <= ts;
end somador16bits;


-----------------------------------------------------------------------
------------------------------ULA--------------------------------------
-----------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

entity ula is
	port (
		a: in std_logic_vector(15 downto 0);
		b: in std_logic_vector(15 downto 0);
		x, y, z: in std_logic;
		s: out std_logic_vector(15 downto 0);
		couterro: out std_logic
	);
end ula;

architecture ula of ula is
	component CompLog
	port (
		a: in std_logic_vector(15 downto 0);
		b: in std_logic_vector(15 downto 0);
		x, y, z: in std_logic;
		ia: out std_logic_vector (15 downto 0);
		ib: out std_logic_vector(15 downto 0);
		Cin: out std_logic;
		Cout: out std_logic
	);
	end component;

	component somador16bits
	port (
		a: in std_logic_vector(15 downto 0);
		b: in std_logic_vector(15 downto 0);
		cin: in std_logic;
		s: out std_logic_vector(15 downto 0);
		cout: out std_logic
	);
	end component;

	signal ia, ib: std_logic_vector(15 downto 0);
	signal cin, cout, cout2: std_logic;
begin
	complog0: CompLog port map (a, b, x, y, z, ia, ib, cin, cout);
	somador8b0: somador16bits port map (ia, ib, cin, s, cout2);
	couterro <= cout or cout2;
end ula;
--só pra fazer o teste
