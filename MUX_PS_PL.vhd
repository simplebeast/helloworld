----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 22.06.2016 17:26:00
-- Design Name: 
-- Module Name: MUX_PS_PL - Behavioral
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


library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity MUX_PS_PL is
port
 (
   CLK                        : in std_logic;
   RST                        : in std_logic;  
   
   AXI_BUS_ENABLE             : in std_logic;
   SORTING_BUS_ENABLE         : in std_logic;
  
   -- Read/Write signals connected to AXI_TOP
   AXI_WE_PM                  : in  std_logic;
   AXI_WE_SURV_PTR            : in  std_logic;
   AXI_WR_DATA_PM             : in  std_logic_vector(15 downto 0) ; 
   AXI_WR_DATA_SURV_PTR       : in  std_logic_vector(15 downto 0) ; 
   AXI_ADDRESS_BUS_RD         : in  std_logic_vector(11 downto 0) ; 
   AXI_ADDRESS_BUS_WR         : in  std_logic_vector(11 downto 0) ; 
   AXI_RD_DATA_PM             : out std_logic_vector(15 downto 0) ; 
   AXI_RD_DATA_SURV_PTR       : out std_logic_vector(15 downto 0) ;
   -- Read/Write signals connected to  Sorting block 
   SORTING_WE_PM              : in  std_logic;
   SORTING_WE_SURV_PTR        : in  std_logic;
   SORTING_WR_DATA_PM         : in  std_logic_vector(15 downto 0) ;
   SORTING_WR_DATA_SURV_PTR   : in  std_logic_vector(15 downto 0) ;
   SORTING_ADDRESS_BUS_RD     : in  std_logic_vector(11 downto 0) ;
   SORTING_ADDRESS_BUS_WR     : in  std_logic_vector(11 downto 0) ;
   SORTING_RD_DATA_PM         : out std_logic_vector(15 downto 0) ;
   SORTING_RD_DATA_SURV_PTR   : out std_logic_vector(15 downto 0) ;

   -- Signals connected to the JVDD Databse
   JS_DB_ADDRESS_BUS_RD       : out std_logic_vector(11 downto 0) ;
   JS_DB_ADDRESS_BUS_WR       : out std_logic_vector(11 downto 0) ;
   JS_DB_WR_DATA_PM           : out std_logic_vector(15 downto 0) ;
   JS_DB_WR_DATA_SURV_PTR     : out std_logic_vector(15 downto 0) ;
   JS_DB_RD_DATA_PM           : in  std_logic_vector(15 downto 0) ;
   JS_DB_RD_DATA_SURV_PTR     : in  std_logic_vector(15 downto 0) ;
   JS_DB_WE_PM                : out std_logic;
   JS_DB_WE_SURV_PTR          : out std_logic
  );
end MUX_PS_PL;

architecture Behavioral of MUX_PS_PL is

begin


JS_DB_ADDRESS_BUS_RD      <= SORTING_ADDRESS_BUS_RD   when (SORTING_BUS_ENABLE = '1') else AXI_ADDRESS_BUS_RD; 
JS_DB_WE_PM               <= SORTING_WE_PM            when (SORTING_BUS_ENABLE = '1') else AXI_WE_PM;
JS_DB_WE_SURV_PTR         <= SORTING_WE_SURV_PTR      when (SORTING_BUS_ENABLE = '1') else AXI_WE_SURV_PTR;
JS_DB_WR_DATA_PM          <= SORTING_WR_DATA_PM       when (SORTING_BUS_ENABLE = '1') else AXI_WR_DATA_PM;
JS_DB_WR_DATA_SURV_PTR    <= SORTING_WR_DATA_SURV_PTR when (SORTING_BUS_ENABLE = '1') else AXI_WR_DATA_SURV_PTR;
JS_DB_ADDRESS_BUS_WR      <= SORTING_ADDRESS_BUS_WR   when (SORTING_BUS_ENABLE = '1') else AXI_ADDRESS_BUS_WR;

SORTING_RD_DATA_PM        <= JS_DB_RD_DATA_PM       ;   --  when (SORTING_BUS_ENABLE = '1') else (others =>'0');
SORTING_RD_DATA_SURV_PTR  <= JS_DB_RD_DATA_SURV_PTR ; 
AXI_RD_DATA_PM            <= JS_DB_RD_DATA_PM       ;   --  when (AXI_BUS_ENABLE = '1')     else (others =>'0');
AXI_RD_DATA_SURV_PTR      <= JS_DB_RD_DATA_SURV_PTR ;   --  when (AXI_BUS_ENABLE = '1')     else (others =>'0');
-- This file is for testing purposess only
end Behavioral;
