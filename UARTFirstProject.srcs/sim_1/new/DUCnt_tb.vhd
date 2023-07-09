----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06/11/2023 07:12:05 PM
-- Design Name: 
-- Module Name: DUCnt_tb - Behavioral
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

entity DUCnt_tb is
--  Port ( );
end DUCnt_tb;

architecture Behavioral of DUCnt_tb is
 
component DU_Cnt is 
    port (  loadFlag : in std_logic;
            shiftFlag : in std_logic;  
            clk : in std_logic; 
            data : in std_logic_vector (7 downto 0); 
            shiftDone : out std_logic; 
            serialOUT : out std_logic
    );
end component; 

signal clk, loadFlag, shiftFlag, shiftDone, serialOUT : std_logic; 
signal data : std_logic_vector (7 downto 0); 

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

    uut : DU_Cnt 
    port map (
        loadFlag => loadFlag, 
        shiftFlag => shiftFlag,
        clk => clk,
        data => data,
        shiftDone => shiftDone, 
        serialOUT => serialOUT
    ); 

    stim : process 
    begin
        data <= "01101010"; 
        loadFlag <= '0'; 
        shiftFlag <= '0';

        wait for 40ns; 

        loadFlag <= '1'; 

        wait for 10ns; 

        loadFlag <= '0'; 

        wait for 10ns;

        shiftFlag <= '1'; 

        wait for 320ns; 

        data <= "00111010"; 

        wait for 320ns; 

        shiftFlag <= '0'; 

        wait for 60ns; 
        
        loadFlag <= '1'; 

        wait for 10ns; 

        loadFlag <= '0'; 

        wait for 10ns;

        shiftFlag <= '1';

        wait for 640ns; 

        shiftFlag <= '0'; 
        
        wait; 

    end process ; -- stim

end Behavioral;
