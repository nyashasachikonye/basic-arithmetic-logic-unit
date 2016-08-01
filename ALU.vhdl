LIBRARY altera;
USE altera.maxplus2.all;
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;

entity ALU is
port (
	opcode: IN std_logic_vector (4 downto 0); -- 8 bit opcode inputs (TODO: change this to 5 bit)
	inA: IN std_logic_vector (7 downto 0); -- 8 bit input bus,
	inB: IN std_logic_vector (7 downto 0); -- 8 bit input bus
	clock: IN std_logic;
	result: OUT std_logic_vector (7 downto 0); -- 8 bit output
	flagN, flagC, flagZ: OUT std_logic);
end ALU;

architecture behavioural of ALU is
begin
process (clock)
variable acc: std_logic_vector (7 downto 0);
variable temp: std_logic_vector(7 downto 0);
begin
if(clock'event and  clock = '1') then
case opcode is

	-- addition
	when "11011" =>
		acc := inA + inB;
		result <= acc;
		-- if(result < 0) then
		flagN <= '0';
		-- if (result == 0) then
		flagZ <= '0';
		-- if (result ? ) then
		flagC <= '0';

	-- bitwise AND
	when "10100" =>
		acc := inA AND inB;
		result <= acc;
		-- if(result < 0) then
		flagN <= '0';
		-- if (result == 0) then
		flagZ <= '0';

	-- clear && clear ACC
	when "01111" =>
		acc := "00000000";
		result <= acc;
		-- if(result < 0) then
		flagN <= '0';
		-- if (result == 0) then
		flagZ <= '0';

	-- compare
	when "10001" =>
		if(inB = inA) then
			acc := inB - inA;
			result <= acc;
			-- if(result < 0) then
			flagN <= '0';
			-- if (result == 0) then
			flagZ <= '1';
			-- if (result ? ) then
			flagC <= '0';
		else
			acc := inB - inA;
			result <= acc;
			-- if(result < 0) then
			flagN <= '0';
			-- if (result == 0) then
			flagZ <= '0';
			-- if (result ? ) then
			flagC <= '0';
		end if;

	-- ones compliment && ones compliment ACC
	when "00011" =>
		acc := NOT(inA);
		result <= acc;
		-- if(result < 0) then
		flagN <= '0';
		-- if (result == 0) then
		flagZ <= '0';
		-- if (result ? ) then
		flagC <= '1';


	-- decrement & decrement ACC
	when "01010" =>
		acc := inA - 1;
		result <= acc;
		-- if(result < 0) then
		flagN <= '0';
		-- if (result == 0) then
		flagZ <= '0';

	-- exclusive OR
	when "11000" =>
		acc := inB XOR inA;
		result <= acc;
		-- if(result < 0) then
		flagN <= '0';
		-- if (result == 0) then
		flagZ <= '0';

	-- increment && increment ACC
	when "01100" =>
		acc := inA + 1;
		result <= acc;
		-- if(result < 0) then
		flagN <= '0';
		-- if (result == 0) then
		flagZ <= '0';

	-- load ACC
	when "10110" =>
		-- if(result < 0) then
		flagN <= '0';
		-- if (result == 0) then
		flagZ <= '0';

	-- logical shift left && logical shift left ACC
	when "01000" =>
		acc := inA(6 downto 0) & "0";
		result <= acc;
		-- if(result < 0) then
		flagN <= '0';
		-- if (result == 0) then
		flagZ <= '0';
		-- if (result == 0) then
		flagC <= '0';

	-- logical shift right && logical shift right ACC
	when "00100" =>
		acc := "0" & inA(7 downto 1);
		result <= acc;
		-- if(result < 0) then
		flagN <= '0';
		-- if (result == 0) then
		flagZ <= '0';
		-- if (result == 0) then
		flagC <= '0';

	-- move immediate
	when "01110" =>
		acc := inA;
		result <= acc;
		-- if(result < 0) then
		flagN <= '0';
		-- if (result == 0) then
		flagZ <= '0';

	-- bitwise OR
	when "11010" =>
		acc := inA OR inB;
		result <= acc;
		-- if(result < 0) then
		flagN <= '0';
		-- if (result == 0) then
		flagZ <= '0';

	-- store ACC
	when "10111" =>
		-- if(result < 0) then
		flagN <= '0';
		-- if (result == 0) then
		flagZ <= '0';

	-- subtract
	when "10000" =>
		acc := inA - inB;
		result <= acc;
		-- if(result < 0) then
		flagN <= '0';
		-- if (result == 0) then
		flagZ <= '0';
		-- if (result == 0) then
		flagC <= '0';

	when others =>
		flagN <= '0';

end case;
end if;
end process;
end behavioural;