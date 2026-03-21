📱 ReliefNet – High-Trust Medical Network

🩺 Overview

ReliefNet is a SwiftUI-based iOS application designed to simplify and streamline doctor-patient interactions.
It focuses on trust, appointment management, and structured communication between patients and healthcare providers.

The app provides a clean and intuitive interface for:
	•	Booking appointments
	•	Managing requests
	•	Tracking confirmations
	•	Handling rescheduling

⸻

🚀 Features

👤 Patient Side
	•	Request appointments with doctors
	•	Select preferred date & time
	•	Add symptoms/notes
	•	View appointment status

🩺 Doctor Side
	•	View incoming booking requests
	•	Accept / Reject appointments
	•	Reschedule appointments
	•	Manage confirmed bookings

🔄 Appointment Management
	•	Separate views for:
	•	New Requests
	•	Confirmed Appointments
	•	Reschedule functionality
	•	Cancel option for better control

⸻

🧱 Tech Stack

📱 Frontend
	•	SwiftUI
	•	MVVM Architecture
	•	Combine (for reactive updates)

💾 Data Handling
	•	Local Storage (for offline support)
	•	Firebase (planned for sync & backend)

⸻

🧩 Architecture

The app follows the MVVM (Model-View-ViewModel) architecture:
	•	Model → Booking data structure
	•	View → SwiftUI UI components
	•	ViewModel → Business logic & state management

This ensures:
	•	Clean separation of concerns
	•	Scalable codebase
	•	Easy testing and maintenance

⸻

🔁 Core Flow
	1.	Patient sends booking request
	2.	Doctor receives request
	3.	Doctor:
	•	Accepts → Appointment confirmed
	•	Rejects → Request removed
	•	Reschedules → New time assigned
	4.	Appointment moves to confirmed list

⸻

🎯 Future Enhancements
	•	🔔 Push Notifications
	•	📹 Video Consultation (WebRTC / CallKit)
	•	☁️ Full Firebase Integration
	•	🔐 Authentication System
	•	📊 Doctor Analytics Dashboard

⸻

💡 Key Highlights
	•	Clean and modern SwiftUI UI
	•	Real-world healthcare use case
	•	Scalable architecture (MVVM)
	•	Offline-first approach (planned)

⸻

📸 Screenshots
Role Selection UI:

<img width="200" alt="Simulator Screenshot - iPhone 17 Pro - 2026-03-21 at 17 18 45" src="https://github.com/user-attachments/assets/6dff8628-fced-4ff3-946b-de54e808ec57" />
<img width="200" alt="Simulator Screenshot - iPhone 17 Pro - 2026-03-21 at 17 18 53" src="https://github.com/user-attachments/assets/14c4e5cf-580f-4fe1-a602-af9af89473b4" />
<img width="200" alt="Simulator Screenshot - iPhone 17 Pro - 2026-03-21 at 17 53 45" src="https://github.com/user-attachments/assets/a7ef3bf5-d66d-475a-840b-b0fa816d9688" />

Doctor Side UI:


<img width="200" alt="Simulator Screenshot - iPhone 17 Pro - 2026-03-21 at 17 16 07" src="https://github.com/user-attachments/assets/e8eb8720-388f-44f1-8a9c-c2061f00aee0" />
<img width="200" alt="Simulator Screenshot - iPhone 17 Pro - 2026-03-21 at 17 16 16" src="https://github.com/user-attachments/assets/ad19b1e9-b012-49d6-9453-06cac0fb020c" />
<img width="200" alt="Simulator Screenshot - iPhone 17 Pro - 2026-03-21 at 17 16 26" src="https://github.com/user-attachments/assets/c5767530-8f95-4331-af02-ab354c128172" />
<img width="200" alt="Simulator Screenshot - iPhone 17 Pro - 2026-03-21 at 17 16 33" src="https://github.com/user-attachments/assets/0bfe21d8-a3d3-4589-8306-ac04614b578d" />
<img width="200" alt="Simulator Screenshot - iPhone 17 Pro - 2026-03-21 at 17 19 51" src="https://github.com/user-attachments/assets/b7d96e06-15c5-41c0-a238-a7e6fd9e5a6d" />

Patient Side UI:


<img width="200" alt="Simulator Screenshot - iPhone 17 Pro - 2026-03-21 at 17 19 24" src="https://github.com/user-attachments/assets/2c388a3d-e11d-4ec4-a169-ee375dad4733" />
<img width="200" alt="Simulator Screenshot - iPhone 17 Pro - 2026-03-21 at 17 19 34" src="https://github.com/user-attachments/assets/1b9633c9-d131-45d4-9b9a-0b6cbcac8209" />
<img width="200" alt="Simulator Screenshot - iPhone 17 Pro - 2026-03-21 at 17 19 40" src="https://github.com/user-attachments/assets/9d5fdde9-9725-470e-92be-9d884e27d2e5" />
<img width="200" alt="Simulator Screenshot - iPhone 17 Pro - 2026-03-21 at 17 20 26" src="https://github.com/user-attachments/assets/10497d23-1fe2-4cfb-9500-5fd3badb61db" />
<img width="200" alt="Simulator Screenshot - iPhone 17 Pro - 2026-03-21 at 17 20 31" src="https://github.com/user-attachments/assets/8d82cf58-0e5e-4e05-b359-af90575d83f3" />
<img width="200" alt="Simulator Screenshot - iPhone 17 Pro - 2026-03-21 at 17 19 43" src="https://github.com/user-attachments/assets/7f20f7ba-f5b0-4ddd-86b1-3a95b401fe11" />
<img width="200" alt="Simulator Screenshot - iPhone 17 Pro - 2026-03-21 at 17 19 48" src="https://github.com/user-attachments/assets/f7e54ba4-8a03-4f77-a39c-e76f60191737" />
<img width="200" alt="Simulator Screenshot - iPhone 17 Pro - 2026-03-21 at 17 16 44" src="https://github.com/user-attachments/assets/d7311d78-c961-4873-ae2a-fe98b303146d" />

⸻

👨‍💻 Author

Ayush Singh
iOS Developer | SwiftUI Enthusiast

⸻

📌 Note

This project is currently in UI + local logic phase. Backend integration and real-time features are under development.

⸻

⭐️ Show Your Support

If you like this project, consider giving it a ⭐️ on GitHub!
