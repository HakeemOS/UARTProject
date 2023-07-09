----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/29/2023 08:13:43 AM
-- Design Name: 
-- Module Name: paraPcr_p - Behavioral
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

-- Important Info: sync resets require FFs instead of LUT and BRAM (block ram)
package paraPcr_p is

    signal sCntLead : std_logic; 
    signal sCntFollow : std_logic; 

    procedure SAEn_nBitReg (signal en : in std_logic; 
                            signal sclr : in std_logic;
                            signal aclr : in std_logic;
                            signal clk : in std_logic; 
                            signal a : in std_logic_vector; 
                            signal q : out std_logic_vector
    ); 

    procedure EdgeDetect (  signal start : in std_logic;
                            signal clk : in std_logic; 
                            signal startOUT : out std_logic; 
                            signal sCountLead : inout std_logic; 
                            signal sCountFollow : inout std_logic 
    );

    procedure SAEn_nShReg ( signal en : std_logic; 
                            signal LR : std_logic; 
                            signal sclr : in std_logic;
                            signal aclr : in std_logic;
                            signal clk : in std_logic; 
                            signal shIN : in std_logic;
                            signal a : in std_logic_vector; 
                            signal q : out std_logic_vector
    );

    procedure nShReg (  signal LR : in std_logic; 
                        signal clk : in std_logic;
                        signal shIN : in std_logic;
                        signal a : in std_logic_vector; 
                        signal q : out std_logic_vector
    ); 

    procedure nShRegO ( signal LR : in std_logic; 
                        signal clk : in std_logic;
                        signal shIN : in std_logic;
                        signal a : in std_logic_vector; 
                        signal shOUT : out std_logic; 
                        signal q : out std_logic_vector

    ); 



end package;

package body paraPcr_p is


    -- N-bit Register w/sync, async, and enable
    procedure SAEn_nBitReg (signal en : in std_logic; 
                            signal sclr : in std_logic;
                            signal aclr : in std_logic;
                            signal clk : in std_logic;
                            signal a : in std_logic_vector; 
                            signal q : out std_logic_vector 
                        
    ) is
    begin
        if (aclr = '1') then
            q <= (others => '0'); 
        elsif (rising_edge(clk)) then
            if (sclr = '1') then
                q <= (others => '0'); 
            elsif (sclr = '0') then
                if (en = '1') then
                    q <= a; 
                end if ;
            end if ;    
        end if ;
    end procedure; 
    

    -- Edge Detector (for button press)
    procedure EdgeDetect (  signal start : in std_logic;
                            signal clk : in std_logic;
                            signal startOUT : out std_logic;
                            signal sCountLead : inout std_logic; 
                            signal sCountFollow : inout std_logic 
    ) is 
    begin 
        if (rising_edge(clk)) then
            sCountLead <= start;
            sCountFollow <= sCountLead;
            startOUT <= sCountLead and (not sCountFollow);            
        end if ;
    end procedure; 


    -- N-bit shift Register w/sync, async clear, and enable; Default is right shift (LR = '0')
    procedure SAEn_nShReg ( signal en : in std_logic; 
                            signal LR : in std_logic; 
                            signal sclr : in std_logic; 
                            signal aclr : in std_logic; 
                            signal clk : in std_logic; 
                            signal shIN : in std_logic; 
                            signal a : in std_logic_vector; 
                            signal q : out std_logic_vector
    ) is 
    begin 
        if (aclr = '1') then
            q <= (others => '0'); 
        elsif (rising_edge(clk)) then
            if (sclr = '1') then
                q <= (others => '0'); 
            elsif (sclr = '0') then
                if (en = '1') then
                    if (LR = '0') then
                        q <= shIN & a(a'high downto a'low + 1  ); 
                    elsif (LR = '1') then
                        q <= a(a'high - 1 downto a'low) & shIN;
                    end if ;
                end if ;
            end if ;
        end if ;
    end procedure; 


    -- N-bit shift Register; Default is right shift (LR = '0')
    procedure nShReg(   signal LR : in std_logic;
                        signal clk : in std_logic;
                        signal shIN : in std_logic;
                        signal a : in std_logic_vector; 
                        signal q : out std_logic_vector
    ) is 
    begin
        if (rising_edge(clk)) then
            if (LR = '0') then
                q <= shIN & a(a'high downto a'low + 1  ); 
            elsif (LR = '1') then
                q <= a(a'high - 1 downto a'low) & shIN;
            end if ;
        end if ;
    end procedure; 


    -- N-bit shift Register w/OUT; Default is right shift (LR = '0')
    procedure nShRegO ( signal LR : in std_logic; 
                        signal clk : in std_logic;
                        signal shIN : in std_logic;
                        signal a : in std_logic_vector; 
                        signal shOUT : out std_logic; 
                        signal q : out std_logic_vector

    ) is 
    begin
        if (rising_edge(clk)) then
            if (LR = '0') then
                q <= shIN & a(a'high downto a'low + 1  );
                shOUT <= a(a'low);  
            elsif (LR = '1') then
                q <= a(a'high - 1 downto a'low) & shIN;
                shOUT <= a(a'high); 
            end if ;
        end if ;
    end procedure; 


end package body;

