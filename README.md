# BeastBurn 👾 🔥

**BeastBurn** is a gamified interactive fitness app for the Apple Watch (watchOS). This app transforms your workout routine into an epic battle, where your real-world heart rate serves as your Attack Power to defeat a virtual monster.

## ✨ Key Features

- 🎮 **Gamified Workouts:** Turn physical activity into a fun game. The harder you work out (within a safe limit), the stronger your attack.
- ❤️ **Real-time Heart Rate Integration:** Reads heart rate data directly from the Apple Watch sensors to determine the _damage_ dealt to the monster.
- 🎯 **Dynamic Heart Rate Zones:** You must maintain your workout intensity, and every age has different range zones.
  - **Safe Zone (eg. 81 - 135 BPM):** Deals continuous damage to the monster.
  - **Warning (eg. &lt;= 80 BPM or &gt;= 136 BPM):** If your heart rate is too low or too high, the monster will heal itself.
- 📊 **Workout Metrics Tracking:** Monitors essential metrics during your activity:
  - Duration (Time)
  - Heart Rate (BPM)
  - Calories Burned (Kcal)
  - Distance (KM)
- 🏆 **Summary & Score:** Once the monster is defeated, view your final workout statistics along with your _Score_ and _High Score_.

## 📱 App Screens

1. **Age Input:** Users enter their age to calibrate the heart rate data.
2. **How To Play:** A brief explanation of the game rules and heart rate boundaries.
3. **Workout View (Swipeable):**
   - _Left Page:_ Workout statistics dashboard (Time, BPM, Kcal, Distance, and a Pause button).
   - _Right Page:_ Live battle view showing the monster's remaining Health Points (HP).
4. **Summary:** The victory screen displaying the final score, average BPM, total distance, and calories burned.

## 🛠️ Technologies Used

- **Platform:** watchOS
- **Language:** Swift
- **UI Framework:** SwiftUI
- **Health Framework:** HealthKit (to access heart rate, calories, and workout metrics)

## 🏃‍♂️ How to Play

1. Open the **BeastBurn** app on your Apple Watch.
2. Enter your age when prompted.
3. Read the instructions, then tap **PLAY**.
4. Start your physical activity (running, cycling, aerobics, etc.).
5. Swipe right to view the monster and its remaining health (HP).
6. **Keep your rhythm!** Ensure your heart rate stays within the target zone (e.g., 81 - 135 BPM) so the monster keeps taking damage and doesn't heal.
7. Keep moving until the monster's HP reaches zero (0).
8. Collect your highest score and share your fitness achievements!

_Built to make every drop of sweat count._
