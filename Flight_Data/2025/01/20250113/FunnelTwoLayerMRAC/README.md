# UAV Flight Log Summary – January 13, 2025

## **Trajectory Following Tests (Nominal & Off-Nominal Conditions)**

<p align="center">
  <img src="/Images/X8_nominal.png" alt="X8-Copter during nominal test flight" width="40%">
</p>
<p align="center">
  <em>Figure: X8-Copter in nominal condition for performing trajectory tracking tests.</em>
</p>

<p align="center">
  <img src="/Images/drone_real_with_2steelballs_cropped.jpg" alt="X8-Copter during off-nominal test flight" width="40%">
</p>
<p align="center">
  <em>Figure: X8-Copter in off-nominal condition for performing trajectory tracking tests.</em>
</p>

**Test Conditions:**
- **Platform:** X8-Copter  
- **Configuration:** Nominal conditions: standard configuration (no payload attached). Off-nominal conditions:  equipped with a 0.520 kg steady payload (transparent plastic box rigidly fixed to the frame) and a 0.260 kg unsteady payload (two steel balls, 0.130 kg each, 0.3175 m diameter)
- **Controller:** FunnelTwoLayerMRAC, TwoLayerMRAC  
- **Trajectory:** Stadium-like (`bean_trajectory0p6.json`) 
- **Objective:** Evaluate trajectory tracking performance under nominal and off-nominal operating conditions  

---

### **Flight Logs**

| Log Filename                    | Notes                           |
|---------------------------------|---------------------------------|
| `workspace_log_20250113_171504` | Nominal conditions. Two-Layer MRAC controller.       |
| `workspace_log_20250113_184244` | Nominal conditions. Funnel Two-Layer MRAC controller. |
| `workspace_log_20250113_190950` | Off-nominal conditions. Two-Layer MRAC controller.       |
| `workspace_log_20250113_201341` | Off-nominal conditions. Funnel Two-Layer MRAC controller. |
