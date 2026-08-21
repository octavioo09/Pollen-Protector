# 🐝 Pollen Protector

**Project Role:** `ECS Programmer` | `Animation System Developer` | `AI & Collision Developer`  
**Tech Stack:** `GameBoy` | `Z80 Assembly` | `ECS Architecture`  
**Team Size:** `Carbonara Studio`

Pollen Protector is a fast-paced wave-based game developed for the **Video Games I** course at the **University of Alicante**.

Developed specifically for the **GameBoy** using **Z80 Assembly**, the game puts you in the role of a bee defending a beautiful garden from an invasion of hungry insects. The game features multiple enemy types with different behaviors, randomized spawning systems for both enemies and flowers, and a final scoring system.

---

### 🎮 Play the Game

**The latest stable build is available on itch.io:** 👉 **[Play Pollen Protector on itch.io](https://carbonara-studio.itch.io/pollen-protector)**

---

### 📑 Technical & Design Overview

One of the main challenges of this project was creating a complete game while taking into account the severe **memory, processing, and rendering limitations of the GameBoy**, without compromising its gameplay.

As a programmer, I was responsible for developing a fully functional **ECS (Entity Component System) from scratch**, specifically designed for **Z80 Assembly**.

The system was designed to be highly scalable and optimized, allowing hundreds of entities to coexist simultaneously without significantly affecting the game's performance.

I also developed a **global animation system**, contributed to the implementation of a highly optimized **collision system**, and collaborated in the design and development of the enemies' **AI**.

---

### 🚀 Key Systems & My Contributions

Our game follows an **ECS (Entity Component System)** architecture. In this data-driven structure, entities are collections of data, components store that data, and systems process it.

Despite the severe limitations of the GameBoy hardware, the architecture was designed to remain scalable, reusable, and highly optimized.

#### 🧩 Custom ECS Architecture

I developed a custom ECS specifically adapted to the GameBoy's hardware and the limitations of Z80 Assembly.

* **📈 Scalability:** The system allows new projectiles, enemy types, and flower types to be added without modifying its core structure. Entity creation is controlled through **flags**, which select predefined entity templates and assign randomized values such as their position.

* **⚡ Optimization:** The system dynamically manages the GameBoy's rendering workload depending on the number of entities currently present in the scene. A controller adjusts the number of times the screen is updated, increasing or decreasing the rendering frequency to maintain a stable frame rate without compromising the visual output.

* **🧠 Centralized Entity Management:** By efficiently managing all entities through the ECS architecture, the system reduces unnecessary operations and keeps memory usage and processing costs under control.

The combination of reusable entity templates, centralized management, and dynamic rendering control makes the optimization of the ECS one of the most important technical aspects of the project.

---

#### 🎞️ Global Animation System

I developed a **generic animation system** designed to work independently of the sprite being rendered.

Instead of manually implementing each animation, the system reads the number of frames available for each sprite and automatically manages the **current and next frame**.

This makes the system completely reusable and allows new animations to be added without modifying the core animation logic.

---

#### 🤖 Enemy AI System

The enemy AI was designed to provide different behaviors while keeping the computational cost as low as possible.

Instead of calculating the AI every frame, the system updates its decisions **once every four frames**. During these updates, each enemy checks the player's position and determines the direction in which it should move and whether it should attack.

Movement and shooting decisions are represented using **direction flags**, allowing the game to control enemy behavior efficiently without requiring a large amount of memory or continuous calculations.

This approach significantly reduces the processing workload while maintaining responsive enemy behavior.

---

### 🛠️ Additional Technical Features

Beyond the core ECS architecture, I also contributed to several systems essential to the gameplay experience:

* 💥 **Collision System:** Implemented collision detection using **overlap checks**, which are evaluated every four frames. This reduces the number of collision calculations while maintaining reliable interactions between entities.

* 🏆 **Scoring System:** Developed the game's scoring system using **binary calculations**, allowing the final score to be efficiently calculated and displayed using the corresponding number sprites.

* 🌼 **Randomized Spawning System:** Implemented randomized spawning for both enemies and flowers, creating more dynamic gameplay while remaining within the limitations of the GameBoy hardware.

---

### 🎯 Technical Challenges

Developing for the GameBoy required carefully balancing **memory usage, processing time, rendering performance, and gameplay complexity**.

Every system had to be designed around the limitations of the hardware, making optimization a fundamental part of the development process.

The result is a game capable of handling numerous entities, animations, AI calculations, and collision checks while maintaining a stable and responsive gameplay experience on the target hardware.

---

### ✉️ Contact and Feedback
* **GitHub:** [octavioo.09](https://github.com/octavioo09)
* **LinkedIn:** [Octavio Vicent Lloret](https://www.linkedin.com/in/octavioo09/)
* **Email:** octaviovlloret@gmail.com

### 📜 License

Licensed under the **MIT License**.
