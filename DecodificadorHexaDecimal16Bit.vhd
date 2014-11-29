-----------------------------------------------------------------------
--------------------------filete a--------------------------------
-----------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

entity fila is
	port (
		a: in std_logic;
		b: in std_logic;
		c: in std_logic;
		d: in std_logic;
		x: out std_logic
	);
end fila;

architecture fila of fila is
begin
	x <= (not b and not c and not d) or (a and not d) or
		(a and not b and not c) or (not a and b and d) or
		(not a and c) or (b and c);
end fila;

-----------------------------------------------------------------------
--------------------------filete b--------------------------------
-----------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

entity filb is
	port (
		a: in std_logic;
		b: in std_logic;
		c: in std_logic;
		d: in std_logic;
		x: out std_logic
	);
end filb;

architecture filb of filb is
begin
	x <= (not a and not b) or (not a and not c and not d) or
		(a and not c and d) or (not a and c and d) or
		(a and not b and not d);
end filb;

-----------------------------------------------------------------------
--------------------------filete c--------------------------------
-----------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

entity filc is
	port (
		a: in std_logic;
		b: in std_logic;
		c: in std_logic;
		d: in std_logic;
		x: out std_logic
	);
end filc;

architecture filc of filc is
begin
	x <= (not a and (not c or d or b)) or (not c and d) or (a and not b);
end filc;

-----------------------------------------------------------------------
--------------------------filete d--------------------------------
-----------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

entity fild is
	port (
		a: in std_logic;
		b: in std_logic;
		c: in std_logic;
		d: in std_logic;
		x: out std_logic
	);
end fild;

architecture fild of fild is
begin
	x <= (a and not c) or (not b and not c and not d) or (b and not c and d) or
		(not b and c and d) or (not a and c and not d) or (b and c and not d);
end fild;

-----------------------------------------------------------------------
--------------------------filete e--------------------------------
-----------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

entity fil_e is
	port (
		a: in std_logic;
		b: in std_logic;
		c: in std_logic;
		d: in std_logic;
		x: out std_logic
	);
end fil_e;

architecture fil_e of fil_e is
begin
	x <= (not b and not c and not d) or (a and b) or (c and not d) or (a and c);
end fil_e;

-----------------------------------------------------------------------
--------------------------filete f--------------------------------
-----------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

entity filf is
	port (
		a: in std_logic;
		b: in std_logic;
		c: in std_logic;
		d: in std_logic;
		x: out std_logic
	);
end filf;

architecture filf of filf is
begin
	x <= (not a and b and not c) or (b and c and not d) or (not c and not d)
		or (a and not b) or (a and c);
end filf;

-----------------------------------------------------------------------
--------------------------filete g--------------------------------
-----------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

entity filg is
	port (
		a: in std_logic;
		b: in std_logic;
		c: in std_logic;
		d: in std_logic;
		x: out std_logic
	);
end filg;

architecture filg of filg is
begin
	x <= (not a and b and not c) or (a and not b) or (a and d) or
		(not b and c) or (c and not d);
end filg;

-----------------------------------------------------------------------
--------------------decodificador hexadecimal--------------------------
-----------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

entity decodhex is
	port (
		w: in std_logic;
		x: in std_logic;
		y: in std_logic;
		z: in std_logic;
		a: out std_logic;
		b: out std_logic;
		c: out std_logic;
		d: out std_logic;
		e: out std_logic;
		f: out std_logic;
		g: out std_logic
	);
end decodhex;

architecture decodhex of decodhex is
	component fila 
	port (
		a: in std_logic;
		b: in std_logic;
		c: in std_logic;
		d: in std_logic;
		x: out std_logic
	);
	end component;

	component filb 
	port (
		a: in std_logic;
		b: in std_logic;
		c: in std_logic;
		d: in std_logic;
		x: out std_logic
	);
	end component;

	component filc
	port (
		a: in std_logic;
		b: in std_logic;
		c: in std_logic;
		d: in std_logic;
		x: out std_logic
	);
	end component;

	component fild port (
		a: in std_logic;
		b: in std_logic;
		c: in std_logic;
		d: in std_logic;
		x: out std_logic
	);
	end component;

	component fil_e port (
		a: in std_logic;
		b: in std_logic;
		c: in std_logic;
		d: in std_logic;
		x: out std_logic
	);
	end component;

	component filf port (
		a: in std_logic;
		b: in std_logic;
		c: in std_logic;
		d: in std_logic;
		x: out std_logic
	);
	end component;

	component filg port (
		a: in std_logic;
		b: in std_logic;
		c: in std_logic;
		d: in std_logic;
		x: out std_logic
	);
	end component;
	
begin
	filetea: fila port map (w, x, y, z, a);
	fileteb: filb port map (w, x, y, z, b);
	filetec: filc port map (w, x, y, z, c);
	fileted: fild port map (w, x, y, z, d);
	filetee: fil_e port map (w, x, y, z, e);
	filetef: filf port map (w, x, y, z, f);
	fileteg: filg port map (w, x, y, z, g);
end decodhex;

-----------------------------------------------------------------------
----------------------decodificador 16 bits----------------------------
-----------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

entity decodhex16bit is
	port (
		entry: in std_logic_vector(15 downto 0);
		d3: out std_logic_vector (0 to 6); --MS dlay
		d2: out std_logic_vector (0 to 6); --dlay de 7 segmentos
		d1: out std_logic_vector (0 to 6); --dlay de 7 segmentos
		d0: out std_logic_vector (0 to 6)  --LS dlay
		--dlays: 0:a, 1:b, 2:c, 3:d, 4:e, 5:f, 6:g
	);
end decodhex16bit;

architecture decodhex16bit of decodhex16bit is
	component decodhex port (
		w: in std_logic; --bit 3 MSB
		x: in std_logic; --bit 2
		y: in std_logic; --bit 1
		z: in std_logic; --bit 0 LSB
		a: out std_logic; --filetes
		b: out std_logic;
		c: out std_logic;
		d: out std_logic;
		e: out std_logic;
		f: out std_logic;
		g: out std_logic
	);
	end component;
begin
	decod0_3: decodhex port map(entry(3), entry(2), entry(1), entry(0), d0(0), d0(1), d0(2), d0(3), d0(4), d0(5), d0(6));
	--display para 4 bits menos significativos: 3 2 1 0
	decod4_7: decodhex port map(entry(7), entry(6), entry(5), entry(4), d1(0), d1(1), d1(2), d1(3), d1(4), d1(5), d1(6));
	--dlay para 4 bits: 7 6 5 4
	decod8_11: decodhex port map(entry(11), entry(10), entry(9), entry(8), d2(0), d2(1), d2(2), d2(3), d2(4), d2(5), d2(6));
	--dlay para 4 bits: 11 10 9 8
	decod12_15: decodhex port map(entry(15), entry(14), entry(13), entry(12), d3(0), d3(1), d3(2), d3(3), d3(4), d3(5), d3(6));
	--dlay para 4 bits mais significativos: 15 14 13 12
end decodhex16bit;
