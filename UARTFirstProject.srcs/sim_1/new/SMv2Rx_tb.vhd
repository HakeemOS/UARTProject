----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07/15/2023 04:55:47 PM
-- Design Name: 
-- Module Name: SMv2Rx_tb - Behavioral
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

entity SMv2Rx_tb is
--  Port ( );
end SMv2Rx_tb;

architecture Behavioral of SMv2Rx_tb is

component SMv2_Rx is 
    port (  clk : in std_logic; 
            startRead : in std_logic; 
            doneRead : in std_logic; 
            validated : in std_logic; 
            invalid : in std_logic; 
            rst : in std_logic; 
            readingFlag : out std_logic; 
            RxDone : out std_logic
    );
end component; 

signal clk, startRead, doneRead, validated, invalid, rst, readingFlag, RxDone : std_logic; 

signal clk_period : time := 20ns; 
signal clk_stop : boolean; 

begin

    clkproc : process 
    begin
        clk <= '1';  
        wait for clk_period/2; 
        clk <= '0'; 
        wait for clk_period/2; 
    end process ; -- clkproc

    uut : SMv2_Rx 
    port map (
        clk => clk, 
        startRead => startRead, 
        doneRead => doneRead, 
        validated => validated, 
        invalid => invalid, 
        rst => rst, 
        readingFlag => readingFlag, 
        RxDone => RxDone
    ); 

    stim : process 
    begin
        
        startRead <= '0'; 
        doneRead <= '0'; 
        validated <= '0'; 
        invalid <= '0'; 
        rst <= '0';

        wait for 40ns; 

        startRead <= '1';
        
        wait for 20ns; 

        startRead <= '0'; 

        wait for 200ns; 

        doneRead <= '1'; 

        wait for 20ns; 

        validated <= '1'; 

        wait for 20ns; 

        doneRead <= '0'; 
        validated <= '0'; 

        wait; 
    end process ; -- stim
end Behavioral;
