----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06/11/2023 06:49:39 PM
-- Design Name: 
-- Module Name: DU_Cnt - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity DU_Cnt is
    port (  loadFlag : in std_logic;
            shiftFlag : in std_logic;  
            clk : in std_logic; 
            data : in std_logic_vector (7 downto 0); 
            shiftDone : out std_logic; 
            serialOUT : out std_logic
    );
end DU_Cnt;

architecture Behavioral of DU_Cnt is

-- Components --
component DU_s is 
    generic (N : integer := 8); 
    port (  loadFlag : in std_logic;
            shiftFlag : in std_logic; 
            shiftData : in std_logic; 
            clk : in std_logic; 
            data : in std_logic_vector (N-1 downto 0); 
            shiftDone : out std_logic; 
            serialOUT : out std_logic
    );
end component; 

component clkCounter_s is 
    port (  clk : in std_logic; 
            shiftFlag : in std_logic; 
            shiftData : out std_logic 
    );
end component; 

-- Signals -- 
signal shiftDataSig : std_logic := '0'; 

begin

    -- Component Maps --
    cnt0 : clkCounter_s 
    port map (
        clk => clk, 
        shiftFlag => shiftFlag, 
        shiftData => shiftDataSig
    );

    DU0 : DU_s
    generic map (N => 8)
    port map (
        loadFlag => loadFlag, 
        shiftFlag => shiftFlag, 
        shiftData => shiftDataSig, 
        clk => clk, 
        data => data,
        shiftDone => shiftDone, 
        serialOUT => serialOUT
    ); 
    

end Behavioral;
