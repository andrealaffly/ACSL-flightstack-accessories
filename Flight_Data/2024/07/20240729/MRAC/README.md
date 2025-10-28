# UAV Flight Log Summary – July 29, 2024

## Hovering Tests (Off-Nominal Conditions)

<p align="center">
  <img src="/Images/drone_real_with_2steelballs_cropped.jpg" alt="X8-Copter during off-nominal test flight" width="40%">
</p>
<p align="center">
  <em>Figure: X8-Copter in off-nominal condition for performing trajectory tracking tests.</em>
</p>

### **Log: `workspace_log_20240729_162628`**  
- **Platform:** X8-Copter  
- **Conditions:** Off-nominal with box and 1 small steel ball  
- **Controller:** MRAC (Unaware of both box and ball)  
- **Objective:** Hovering stability test  

---

### **Log: `workspace_log_20240729_163324`**  
- **Platform:** X8-Copter  
- **Conditions:** Off-nominal with box and 2 small steel balls  
- **Controller:** MRAC (Unaware of both box and balls)  
- **Objective:** Hovering stability test  

---

### **Log: `workspace_log_20240729_163817`**  
- **Platform:** X8-Copter  
- **Conditions:** Off-nominal with box and 2 small steel balls  
- **Controller:** PID (Unaware of both box and balls)  
- **Objective:** Hovering stability test  

---

## Trajectory Following Tests (Off-Nominal Conditions)

### **Log: `workspace_log_20240729_174559`**  
- **Platform:** X8-Copter  
- **Conditions:** Off-nominal with box  
- **Controller:** MRAC (Unaware of box)  
- **Trajectory:** Stadium-like (Slower: `bean_trajectory0p6.json`)  
- **Objective:** Trajectory tracking performance  

---

### **Log: `workspace_log_20240729_175519`**  
- **Platform:** X8-Copter  
- **Conditions:** Off-nominal with box and 1 small steel ball  
- **Controller:** MRAC (Unaware of both box and ball)  
- **Trajectory:** Stadium-like (Slower: `bean_trajectory0p6.json`)  
- **Objective:** Trajectory tracking performance  

---

### **Log: `workspace_log_20240729_175931`**  
- **Platform:** X8-Copter  
- **Conditions:** Off-nominal with box and 1 small steel ball  
- **Controller:** PID (Unaware of both box and ball)  
- **Trajectory:** Stadium-like (Slower: `bean_trajectory0p6.json`)  
- **Objective:** Trajectory tracking performance  
