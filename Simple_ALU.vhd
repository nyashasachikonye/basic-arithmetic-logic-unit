LIBRARY ieee;

USE ieee.std_logic_1164.ALL
USE ieee.std_logic_unsigned.ALL

ENTITY ALU IS
	PORT (
		clk : IN std_logic;
		A, B, : IN std_logic_vector(3 DOWNTO 0);
		AAND, AORB, AINC : std_logic_vector(3 DOWNTO 0)
	);

END ALU;

ARCHITECTURE behave OF ALU IS

BEGIN
	PROCESS (CLK)

BEGIN
	IF CLK'EVENT AND CLOCK = '1' THEN

		AANDB <= A AND B;
		AORB <= A OR B;
		AINC <= A + 1;

	END IF;

END PROCESS;

END behave;
