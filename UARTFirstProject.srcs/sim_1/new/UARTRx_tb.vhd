----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07/13/2023 09:39:33 PM
-- Design Name: 
-- Module Name: UARTRx_tb - Behavioral
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

entity UARTRx_tb is
--  Port ( );
end UARTRx_tb;

architecture Behavioral of UARTRx_tb is

component UART_Rx is 
    port (  clk : in std_logic; 
            start : in std_logic;
            TxData : in std_logic;
            rst : in std_logic; 
            validated : out std_logic; 
            invalid : out std_logic; 
            RxDone : out std_logic; 
            data : out std_logic_vector (7 downto 0)
    ); 
end component; 

signaL start, TxData, rst, validated, invalid, RxDone : std_logic; 
signal data : std_logic_vector (7 downto 0); 

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

    uut : UART_Rx
    port map (
        clk => clk, 
        start => start, 
        TxData => TxData, 
        rst => rst, 
        validated => validated, 
        invalid => invalid, 
        RxDone => RxDone, 
        data => data
    );

    stim : process
    begin

        start <= '0'; 
        TxData <= '0'; 
        rst <= '0'; 
        
        wait for 20ns; 
        
    end process ; -- stim


end Behavioral;
