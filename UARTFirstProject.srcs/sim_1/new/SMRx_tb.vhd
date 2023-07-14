----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07/11/2023 02:28:14 PM
-- Design Name: 
-- Module Name: SMRx_tb - Behavioral
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

entity SMRx_tb is
--  Port ( );
end SMRx_tb;

architecture Behavioral of SMRx_tb is

component SM_Rx is 
    port (  clk : in std_logic; 
            startO : in std_logic; 
            startRead : in std_logic; 
            doneRead : in std_logic; 
            validated : in std_logic;
            invalid : in std_logic; 
            rst : in std_logic; 
            setupFlag : out std_logic; 
            RxDone : out std_logic 
    );
end component; 

signal clk, startO, startRead, doneRead, validated, invalid, rst, setupFlag, RxDone : std_logic; 

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

    uut : SM_Rx 
    port map (
        clk => clk, 
        startO => startO, 
        startRead => startRead, 
        doneRead => doneRead,
        validated => validated, 
        invalid => invalid, 
        rst => rst, 
        setupFlag => setupFlag, 
        RxDone => RxDone
    );

    stim : process 
    begin
        startO <= '0'; 
        startRead <= '0'; 
        doneRead <= '0'; 
        validated <= '0'; 
        invalid <= '0'; 
        rst <= '0'; 

        wait for 20ns;

        startO <= '1'; 

        wait for 20ns; 

        startO <= '0'; 

        wait for 10ns; 

        startRead <= '1'; 

        wait for 20ns; 

        startRead <= '0'; 

        wait for 790ns; 

        doneRead <= '1'; 

        wait for 20ns; 

        invalid <= '1'; 

        wait for 20ns; 

        doneRead <= '0'; 
        invalid <= '0'; 

        wait; 








    end process ; -- stim

    
end Behavioral;
