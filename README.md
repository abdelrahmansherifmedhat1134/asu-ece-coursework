# Ain Shams ECE coursework

Course labs, assignments and mini-projects from my Electronics and Communications Engineering degree at Ain Shams University (2024–2026): MATLAB signal processing and communications, LTspice circuits, Simulink control models, Verilog, C/C++ and MIPS assembly.

**Author:** Abdelrahman Sherif (student ID 2300100). Lab reports marked *group* were written with the classmates named on their cover page.

Larger course projects have their own repos:
[power-supply-and-audio-amplifier](https://github.com/abdelrahmansherifmedhat1134/power-supply-and-audio-amplifier) (ECE211s),
[solar-tracker-simscape](https://github.com/abdelrahmansherifmedhat1134/solar-tracker-simscape) (CSE271s),
[asemn-environmental-monitoring-node](https://github.com/abdelrahmansherifmedhat1134/asemn-environmental-monitoring-node) (ECE391s).

## Index

| Course | Task | Files | Key result |
|---|---|---|---|
| ECE352s Analog & Digital Communication Systems (Spr 2026) | Course project: Gram-Schmidt basis functions for M arbitrary signals, constellation diagrams | [`ece352s-communication-systems/course-project/`](ece352s-communication-systems/course-project) (7 MATLAB scripts; `_ver*` / `_Final` are successive versions) | — |
| | Lab experiments 1–4 (group) | [`lab-reports/`](ece352s-communication-systems/lab-reports) | — |
| ECE312s Analog circuits (Spr 2026) | Experiments E1–E5 (group): op-amp circuits | [`ece312s-analog-circuits/`](ece312s-analog-circuits) (5 reports, 5 LTspice schematics) | — |
| DSP (Spr 2026) | Assignments 1–2, lab E4 (group) | [`dsp/`](dsp) | — |
| Computer networks (Spr 2026) | Assignments 1–2 | [`computer-networks/`](computer-networks) | — |
| ECE431 Optoelectronics (Spr 2026) | Fabry-Perot semiconductor laser: carrier/photon rate-equation simulation | [`optoelectronics-project/`](optoelectronics-project) | [plots](optoelectronics-project/plots) |
| Waveguides (Spr 2026) | Major task: slab waveguide confinement factor; assignment 1 | [`waveguides/`](waveguides) | [output-1.png](waveguides/major-task/plots/output-1.png) |
| ECE311s Digital circuits (Fall 2025) | CMOS inverter, D flip-flop setup/hold/t<sub>cq</sub>, divider (LTspice); logic unit + FSM with testbenches (Verilog); lab 3–4 reports (group) | [`ece311s-digital-circuits/`](ece311s-digital-circuits) | — |
| CSE371s Control engineering lab (Fall 2025) | Lab 1 motor and sensor (encoder, gyro, accelerometer) plots, lab 2, lab 3 PID on a twin rotor | [`control-systems/lab1`](control-systems/lab1), [`lab2`](control-systems/lab2), [`lab3`](control-systems/lab3) | [comparison plot](control-systems/lab1/plots/comparison%20plot.jpg) |
| | Motor assignment, phases 1–3: first/second-order models, saturation, IAE-based controller tuning | [`control-systems/motor-assignment/`](control-systems/motor-assignment) (MATLAB + Simulink) | [optimized response](control-systems/motor-assignment/plots/optimized%20response.jpg) |
| ECE331 Electromagnetic waves lab (Fall 2025) | M1 glass lens, M4 plane-wave polarization, M5 normal/oblique incidence | [`ece331-electromagnetic-waves-lab/`](ece331-electromagnetic-waves-lab) | — |
| CSE271s System dynamics (Spr 2025) | Labs 1–4 | [`cse271s-system-dynamics-labs/`](cse271s-system-dynamics-labs) | — |
| EPM213s Electrical measurements (Spr 2025) | Lab reports (PMMC, moving iron, dynamometer, bridges, transducers, op-amp); Smart Street team presentation | [`epm213s-electrical-measurements/`](epm213s-electrical-measurements) | — |
| ECE251s Signals & systems (Spr 2025) | Audio project: energy in time/frequency domain, 10th-order Butterworth filtering | [`ece251s-signals-project/`](ece251s-signals-project) | — |
| Energy conversion lab (Spr 2025) | DC motor, DC generator, transformer, induction motor, PV + MPPT | [`energy-conversion-lab/`](energy-conversion-lab) | [mppt.png](energy-conversion-lab/plots/mppt.png) |
| ECE211s Electronics (Fall 2024) | Lab reports 1–4, LTspice experiments 2–5 | [`electronics-labs/`](electronics-labs) | — |
| Complex analysis | Major task solution (handwritten scan) | [`complex-analysis/`](complex-analysis) | — |
| Real-time embedded systems | C progress reports, labs 1–2 | [`real-time-embedded-systems/`](real-time-embedded-systems) | — |
| Programming | C++ labs, prelabs, recursive series/parallel resistance parser ([`circuit_recursion.cpp`](programming/cpp/circuits-project/circuit_recursion.cpp)) | [`programming/cpp/`](programming/cpp) | — |
| | C lectures and a console clinic-management program | [`programming/c/`](programming/c) | — |
| | MIPS assembly (MARS) | [`programming/mips-assembly/`](programming/mips-assembly) | — |
| | Octave sheets incl. SSB modulation | [`programming/octave-sheets/`](programming/octave-sheets) | — |

## How to run

- **MATLAB / Octave:** open the folder and run the `.m` script. `octave-sheets` use Octave's `signal` package (`pkg load signal`). The signals project reads an audio file that is not included (recordings of classmates' voices); save any recording as `input.wav` next to the script.
- **Simulink:** `.slx` models open in MATLAB/Simulink R2024a or newer. Simulink caches (`slprj/`, `*.slxc`) are not included and are rebuilt on first run.
- **LTspice:** open the `.asc` file and run. The ECE311s schematics `.include` the model files kept next to them: PTM 90 nm / 65 nm bulk models (Predictive Technology Model, ASU) and the CMOSedu long-channel models (Baker, *CMOS Circuit Design, Layout, and Simulation*).
- **Verilog:** compile the module with its `_tb.v` in ModelSim/QuestaSim.
- **C/C++:** `g++ file.cpp -o file` or `gcc file.c -o file`.

## Not included

Course briefs and lab handouts, instructor lab material, textbooks and lecture notes, photos (including WhatsApp images and handwritten analysis photos), audio and video, earlier drafts and `.docx` copies of reports that exist as PDF, and build or simulation output.

## License

Code (`.m`, `.slx`, `.asc`, `.v`, `.c`, `.cpp`, `.h`, `.asm`) is under the [MIT License](LICENSE). The PTM and CMOSedu model files in `ece311s-digital-circuits/ltspice/` keep their original terms. Reports and slides are © their authors and are shared for reference only.
