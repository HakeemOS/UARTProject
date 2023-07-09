----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06/18/2023 08:34:15 AM
-- Design Name: 
-- Module Name: SM_tb - Behavioral
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

entity SM_tb is
--  Port ( );
end SM_tb;

architecture Behavioral of SM_tb is

component SM_s is 
    port (  clk : in std_logic;
            startO : in std_logic; 
            shiftDone : in std_logic; 
            delayIN : in std_logic; 
            rst : in std_logic; 
            loadFlag : out std_logic; 
            shiftFlag : out std_logic; 
            startDelay : out std_logic; 
            TxDone : out std_logic; 
            doneSh : out std_logic 
    );
end component; 

signal startO, shiftDone, delayIN, rst, loadFlag, shiftFlag, startDelay, TxDone, doneSh, clk : std_logic; 

constant clk_period : time := 20ns; 
signal clk_stop : boolean; 

begin

    clkproc : process 
    begin
        clk <= '1';  
        wait for clk_period/2; 
        clk <= '0'; 
        wait for clk_period/2; 
    end process ; -- clkproc

    uut : SM_s 
    port map (
        clk => clk, 
        startO => startO, 
        shiftDone => shiftDone, 
        delayIN => delayIN,
        rst => rst, 
        loadFlag => loadFlag, 
        shiftFlag => shiftFlag, 
        startDelay => startDelay, 
        TxDone => TxDone, 
        doneSh => doneSh
    ); 

    stim : process 
    begin
        startO <= '0'; 
        shiftDone <= '0';
        delayIN <= '0'; 
        rst <= '1'; 

        wait for 40ns; 

        rst <= '0'; 
        delayIN <= '1'; 
        
        wait for 20ns; 

        delayIN <= '0'; 

        wait for 20ns; 

        startO <= '1'; 

        wait for 20ns; 

        startO <= '0'; 

        wait for 180ns; 

        shiftDone <= '1'; 

        wait for 40ns; 

        shiftDone <= '0'; 

        wait for 80ns; 

        delayIN <= '1'; 

        wait for 20ns; 

        delayIN <= '0'; 

        wait; 




    end process ; -- stim

end Behavioral;
