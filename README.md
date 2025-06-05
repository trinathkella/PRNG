## Cellular Automata-Based Pseudo Random Number Generator (CA-PRNG)

This project implements a 32-bit Pseudo Random Number Generator using 1D Cellular Automata (CA) logic combined with a traditional Linear Feedback Shift Register (LFSR). Designed in Verilog, it aims to explore lightweight randomness generation using multiple CA rules.

---

## Features

- 32-bit wide PRNG output
- 5 distinct CA rulesets implemented:
  - Rule 30 (Chaotic)
  - Rule 110
  - Rule 149
  - Rule 105
  - Rule 182
- LFSR-based post-processing stage for entropy enhancement
- Signal-based dynamic rule selection using intermediate CA outputs

---

## Randomness Techniques

- Cellular Automata (CA) rules simulate chaotic behavior
- Dynamic rule selection via XOR/XNOR signals on intermediate states
- Optional LFSR at output stage improves randomness

---

## Learn More

- For more about Cellular Automata and visualising the different rules refer this website -> [Wolfram: Elementary Cellular Automaton](https://mathworld.wolfram.com/ElementaryCellularAutomaton.html)
- For better understanding on how rules are generated -> [YouTube: Cellular Automata Explanation](https://www.youtube.com/watch?v=W1zKu3fDQR8)

