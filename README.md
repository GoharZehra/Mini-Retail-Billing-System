# Mini-Retail-Billing-System

The objective of this project was to create a functional Mini Retail Billing System using 8086 Assembly Language.
The system allows customers to browse a menu, select from five different items, and input desired quantities. The
program then processes these selections to compute totals and generate a final invoice.

### The core requirements for the solution included:
* Platform Compatibility: The project must run exclusively on the EMU8086 emulator.
* Interactive Menu: The system must provide a user-friendly, menu-driven interface for navigation.
* Data Processing: The logic must handle multiple item purchases, calculate sub-totals, and maintain a
grand total.
* Standard Output: All input and output must be text-based and properly formatted for readability.
* Memory Management: Item names and prices must be stored and retrieved using arrays in memory.

### Results and Observations:
The implementation of the Mini Retail Billing System resulted in a stable application that successfully meets all
technical goals. The program manages an inventory of five items and accurately performs the arithmetic required
for retail transactions.

##### SUMMARY OF IMPLEMENTATION:
The system successfully manages a digital inventory of five items using structured arrays for names and prices. The
core logic allows for a continuous shopping loop where a user can add multiple items to a virtual cart. The program
accurately handles integer arithmetic to calculate both individual line-item totals and a cumulative grand total. All
data is processed within the EMU8086 environment, ensuring full compatibility with the 8086 microprocessor
architecture.
##### FUNCTIONAL PERFORMANCE:
The system successfully handles the core logic of a retail transaction. It manages inventory data through memory
arrays and accurately calculates totals using integer arithmetic. The program was observed to maintain a
persistent cart in memory, which allows for multiple items to be processed and summed into a final grand total
without any data loss.
##### INPUT VALIDATION AND STABILITY:
Testing showed that the decision making logic is robust. The program effectively filters out invalid inputs for both
item selection and quantity, ensuring that only valid data enters the calculation phase. Additionally, the system
handles cart capacity scenarios gracefully, automatically directing the user to the invoice generation phase to
prevent memory errors or crashes.
##### OUTPUT CLARITY:
The final output results are highly readable and well structured. By utilizing the AAM instruction to convert
numeric data into displayable characters, the system produces a professional invoice. The use of text based
formatting ensures that the final receipt is easy for a user to interpret within the terminal, providing a clear
breakdown of prices, quantities, and the final amount due.
##### TECHNICAL CONCLUSION:
The implementation confirms that retail billing tasks can be achieved efficiently in Assembly through organized
memory management and logical branching. The program completes all assigned tasks with a small memory
footprint and terminates correctly, returning control to the operating system as intended.


### 🚀 How to Run
1. Download and open [EMU8086](https://emu8086-microprocessor-emulator.com/).
2. Open the `.asm` file inside the emulator.
3. Click **Emulate** and then **Run** to launch the interactive billing menu.
