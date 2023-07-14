----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07/10/2023 07:42:47 PM
-- Design Name: 
-- Module Name: RURxClk_tb - Behavioral
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

entity RURxClk_tb is
--  Port ( );
end RURxClk_tb;

architecture Behavioral of RURxClk_tb is

component RU_RxClk is 
    port (  clk : in std_logic;
            setupFlag : in std_logic; 
            TxData : in std_logic; 
            rst : in std_logic; 
            doneRead : out std_logic;
            validated : out std_logic; 
            invalid : out std_logic; 
            data : out std_logic_vector (7 downto 0) 
    );
end component; 

signal clk, setupFlag, TxData, rst, doneRead, validated, invalid : std_logic; 
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

    dut : RU_RxCLK 
    port map (
        clk => clk, 
        setupFlag => setupFlag, 
        TxData => TxData, 
        rst => rst, 
        doneRead => doneRead, 
        validated => validated, 
        invalid => invalid, 
        data => data
    ); 

    stim : process 
    begin   

        setupFlag <= '0'; 
        TxData <= '0'; 
        rst <= '0'; 
        
        wait for 30ns; 

        setupFlag <= '1'; 

        wait for 20ns; 

        setupFlag <= '0'; 

        wait for 60ns; 

        TxData <= '0'; -- second 

        wait for 80ns; 

        TxData <= '1'; -- third

        wait for 80ns; 

        TxData <= '1'; -- fourth 

        wait for 80ns; 

        TxData <= '0'; --fifth 

        wait for 80ns; 

        TxData <= '1'; --sixth 

        wait for 80ns; 

        TxData <= '1'; -- seventh 

        wait for 80ns; 

        TxData <= '0'; -- eighth

        wait for 80ns; 

        TxData <= '1'; -- ninth 

        wait for 80ns; 

        TxData <= '1'; -- tenth

        wait for 160ns; 

        setupFlag <= '1'; 

        wait for 20ns; 

        setupFlag <= '0'; 

        wait for 60ns; 

        TxData <= '0'; -- second 

        wait for 80ns; 

        TxData <= '1'; -- third

        wait for 80ns; 

        TxData <= '1'; -- fourth 

        wait for 80ns; 

        TxData <= '0'; --fifth 

        wait for 80ns; 

        TxData <= '1'; --sixth 

        wait for 80ns; 

        TxData <= '1'; -- seventh 

        wait for 80ns; 

        TxData <= '0'; -- eighth

        wait for 80ns; 

        TxData <= '1'; -- ninth 

        wait for 80ns; 

        TxData <= '1'; -- tenth

        wait; 

        

    end process ; -- stim

end Behavioral;
