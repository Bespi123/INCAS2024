# README for "An Adaptive Approach for Satellite Inertia Tensor Estimation Applied to Air-Bearing Testbeds"

## Overview
This project presents an adaptive approach to estimating the satellite inertia tensor using an air-bearing testbed developed by the Instituto de Investigación Astronómica y Aeroespacial Pedro Paulet (IAAPP). The research addresses discrepancies between CAD simulations and real-world measurements caused by unmodeled components, such as cables and mass center offsets. The methodology employs three reaction wheels as actuators and an adaptive proportional controller to regulate torque output, demonstrating high accuracy in inertia tensor estimation and effective control of the satellite's angular rate.

## Authors
- **Brayan Espinoza-Garcia**
  - Instituto de Investigación Astronómica y Aeroespacial Pedro Paulet
  - Universidad Nacional de San Agustín de Arequipa, Arequipa, Perú
  - Email: bespinozag@unsa.edu.pe

- **Alfredo Mamani-Saico**
  - Instituto de Investigación Astronómica y Aeroespacial Pedro Paulet
  - Universidad Nacional de San Agustín de Arequipa, Arequipa, Perú
  - Email: amamanisai@unsa.edu.pe

- **Pablo Raul Yanyachi**
  - Instituto de Investigación Astronómica y Aeroespacial Pedro Paulet
  - Universidad Nacional de San Agustín de Arequipa, Arequipa, Perú
  - Email: raulpab@unsa.edu.pe

## Abstract
This paper introduces an adaptive control methodology that utilizes three reaction wheels for accurate inertia tensor estimation. The proposed system mitigates errors arising from unmodeled dynamics and showcases the potential for improving satellite attitude control systems.

## Key Sections
1. **Introduction**
   - Discusses the significance of accurate inertia tensor estimation and challenges encountered in satellite attitude control.
   
2. **Mathematical Models**
   - Covers reference frames, inertia tensor calculations, kinematics and dynamics, and models for flywheels.
   
3. **Flywheels Parameter Estimation and Control**
   - Describes the parameter estimation process for reaction wheels and the development of an adaptive proportional controller.

4. **Algorithm for Inertia Tensor Estimation**
   - Details the online estimation algorithm used to estimate the inertia tensor for the testbed.

5. **Numerical Simulations**
   - Presents results from simulations validating the proposed algorithms for controlling reaction wheels and estimating inertia parameters.

6. **Results and Conclusion**
   - Summarizes findings, including the accuracy of estimated inertia values and performance of the adaptive controller.

## Technical Details
- **Key Equations:**
  - Inertia tensor: \( J^*_B = J_B + m_{sat}[(r \cdot r)I_3 - rr^T] \)
  - Kinematics: \( \dot{q} = \frac{1}{2} \Xi(q) \omega_{BI}^B \)
  - Dynamics: \( \dot{\omega}_{BI}^B = [J^*_B]^{-1}[T_d^B - \dot{h}_w^B - \omega_{BI}^B \times (J^*_B\omega_{BI}^B + h_w^B)] \)

## Installation and Usage
- Ensure MATLAB and the required toolboxes (System Identification Toolbox) are installed.
- Run the provided scripts in MATLAB to simulate and test the proposed adaptive control algorithms.

## References
1. Yanyachi, P., Mamani, A., Wang, X., & Mendoza, J. (2024). Test bench development and functional analysis of a reaction wheel for an ADCS prototype.
2. Carrara, V., & Kuga, H. K. (2013). Estimating friction parameters in reaction wheels for attitude control.
3. Meng, Z., Chen, R., Sun, C., & An, Y. (2010). The mathematical simulation model of brushless DC motor system.
