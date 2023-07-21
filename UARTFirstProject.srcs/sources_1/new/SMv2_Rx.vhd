----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07/15/2023 04:04:50 PM
-- Design Name: 
-- Module Name: SMv2_Rx - Behavioral
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

entity SMv2_Rx is
    port (  clk : in std_logic; 
            startRead : in std_logic; 
            doneRead : in std_logic; 
            validated : in std_logic; 
            invalid : in std_logic; 
            rst : in std_logic; 
            readingFlag : out std_logic; 
            RxDone : out std_logic
    );
end SMv2_Rx;

architecture Behavioral of SMv2_Rx is

type states is (waiting, reading, validating); 

signal stt : states := waiting; 
signal readingFlag_t : std_logic := '0'; 
signal RxDone_t : std_logic := '0'; 

begin
    trns : process( clk, rst, startRead, doneRead, validated, invalid )
    begin
        if (rst = '1') then
            stt <= waiting;
        elsif (rising_edge(clk)) then
            case( stt ) is
                when waiting =>
                    if (startRead = '1') then
                        stt <= reading; 
                    else
                        stt <= waiting; 
                    end if ;
                when reading => 
                    if (doneRead = '1') then
                        stt <= validating; 
                    else
                        stt <= reading; 
                    end if ;
                when others =>
                    if (validated = '1') then
                        stt <= waiting; 
                    elsif (invalid = '1') then
                        stt <= waiting; 
                    end if;
            end case ;
        end if ;
    end process ; -- trns

    output : process( clk )
    begin
        -- Defaults --
        RxDone_t <= '0'; 
        readingFlag_t <= '0'; 
        
        case( stt ) is
            when waiting => RxDone_t <= '1'; 
            when reading => readingFlag_t <= '1';
            when others => RxDone_t <= '1';
        end case ;
    end process ; -- output

    RxDone <= RxDone_t; 
    readingFlag <= readingFlag_t; 
end Behavioral;
