----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07/10/2023 07:07:35 PM
-- Design Name: 
-- Module Name: RU_RxClk - Behavioral
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

entity RU_RxClk is
    generic (N : integer := 8); 
    port (  clk : in std_logic;
            setupFlag : in std_logic; 
            TxData : in std_logic; 
            rst : in std_logic; 
            doneRead : out std_logic;
            validated : out std_logic; 
            invalid : out std_logic; 
            data : out std_logic_vector (N-1 downto 0) 
    );
end RU_RxClk;

architecture Behavioral of RU_RxClk is

    -- Components --
component readClk_Rx is 
    port (  clk : in std_logic;     
            setupFlag : in std_logic; 
            rst : in std_logic; 
            startRead : out std_logic; 
            readFlag : out std_logic 
        );
end component; 

component RU_Rx is 
    generic (N : integer := 8); 
    port (  clk : in std_logic;
            startRead : in std_logic; 
            readFlag : in std_logic; 
            TxData : in std_logic; 
            rst : in std_logic; 
            doneRead : out std_logic;
            validated : out std_logic; 
            invalid : out std_logic; 
            data : out std_logic_vector (N-1 downto 0) 
    ); 
end component; 

-- signals --
signal startRead : std_logic := '0'; 
signal readFlag : std_logic := '0'; 
signal doneRead_t : std_logic := '0'; 
signal validated_t : std_logic := '0'; 
signal invalid_t : std_logic := '0'; 
signal data_t : std_logic_vector (N-1 downto 0) := (others => '0'); 

begin

    RxCLk0 : readClk_Rx
    port map (
        clk => clk, 
        setupFlag => setupFlag, 
        rst => rst, 
        startRead => startRead, 
        readFlag => readFlag
    ); 

    RU0 : RU_Rx 
    port map (
        clk => clk, 
        startRead => startRead, 
        readFlag => readFlag, 
        TxData => TxData, 
        rst => rst, 
        doneRead => doneRead_t, 
        validated => validated_t,
        invalid => invalid_t, 
        data => data_t
    ); 

    doneRead <= doneRead_t; 
    validated <= validated_t; 
    invalid <= invalid_t; 
    data <= data_t; 

end Behavioral;
