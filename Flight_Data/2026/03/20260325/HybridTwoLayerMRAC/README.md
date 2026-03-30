# UAV Flight Log Summary – March 25, 2026

## **Trajectory Following Tests (Nominal Conditions)**

<p align="center">
  <img src="/Images/Gifs/20260325_192810.gif" alt="20260325_192810 flight" width="60%">
</p>
<p align="center">
  <em>Figure: 20260325_192810 flight. Hybrid Error Bounding Control Input Two-Layer MRAC controller.</em>
</p>

<p align="center">
  <img src="/Images/X8_nominal.png" alt="X8-Copter during nominal test flight" width="40%">
</p>
<p align="center">
  <em>Figure: X8-Copter in nominal condition for performing trajectory tracking tests.</em>
</p>

**Test Conditions:**
- **Platform:** X8-Copter  
- **Configuration:** Standard configuration (no payload attached)  
- **Controller:** HybridTwoLayerMRAC, TwoLayerMRAC  
- **Trajectory:** 3D lemniscate (`rollercoaster_trajectory2p0.json`)  
- **Objective:** Evaluate trajectory tracking performance under nominal operating conditions  

---

### **Flight Logs**

| Log Filename                    | Notes                           |
|---------------------------------|---------------------------------|
| `workspace_log_20260325_151519` | Two-Layer MRAC controller       |
| `workspace_log_20260325_192810` | Hybrid Error Bounding Control Input Two-Layer MRAC controller |
