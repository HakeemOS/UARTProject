----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06/13/2023 01:22:54 PM
-- Design Name: 
-- Module Name: TxReady_s - Behavioral
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

entity TxReady_s is
    port (  start : in std_logic; 
            TxDone : in std_logic; 
            delayIN : in std_logic; 
            clk : in std_logic; 
            rst : in std_logic; 
            TxReadyOUT : out std_logic
    );
end TxReady_s;

architecture Behavioral of TxReady_s is

signal initFlag : std_logic := '1'; 

begin

    proc1 : process( clk )
    begin
        if (rst = '1') then
            initFlag <= '1'; 
        elsif (rising_edge(clk)) then
            if (start = '1') then
                initFlag <= '1';
            else 
                initFlag <= '0'; 
            end if ;
        end if ;
    end process ; -- proc1

    TxReadyOUT <= not initFlag and TxDone and not delayIN; 

end Behavioral;
