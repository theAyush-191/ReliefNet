//
//  ChatData.swift
//  ReliefNet
//
//  Created by Ayush Singh on 07/10/25.
//
import Foundation

struct ChatData:Identifiable{
    var id = UUID()
    var date : Date = Date()
    var message : String
    var isSent : Bool
}



// Sample Chat for Doctor's Chat View
let sampleChatData: [ChatData] = [
    ChatData(message: "Hello, how are you feeling today?", isSent: false),
    ChatData(message: "Hi Doctor, I’ve been feeling anxious lately.", isSent: true),
    ChatData(message: "I see. Can you tell me when these feelings usually occur?", isSent: false),
    ChatData(message: "Mostly at night or when I’m alone.", isSent: true),
    ChatData(message: "That’s quite common. Have you noticed any specific triggers?", isSent: false),
    ChatData(message: "Maybe work pressure and lack of sleep.", isSent: true),
    ChatData(message: "Understood. It might help to practice some relaxation techniques before bed.", isSent: false),
    ChatData(message: "Okay, could you suggest a few I can try?", isSent: true),
    ChatData(message: "Sure. Deep breathing, journaling, and a short mindfulness session can help a lot.", isSent: false),
    ChatData(message: "Thanks, I’ll try that tonight.", isSent: true),
    
    // Additional chat
    ChatData(message: "That’s great. Try to be consistent for at least a week and observe how you feel.", isSent: false),
    ChatData(message: "Will do. Should I also reduce my screen time before sleeping?", isSent: true),
    ChatData(message: "Yes, that would help. Avoid screens at least 30 minutes before bed.", isSent: false),
    ChatData(message: "Got it. I’ve also been waking up in the middle of the night sometimes.", isSent: true),
    ChatData(message: "That can be due to anxiety or irregular sleep patterns. Do you drink coffee late in the evening?", isSent: false),
    ChatData(message: "Yes, I usually have a cup around 8 pm.", isSent: true),
    ChatData(message: "Try avoiding caffeine after 5 pm. Replace it with herbal tea or warm water instead.", isSent: false),
    ChatData(message: "Alright, I’ll make that change.", isSent: true),
    ChatData(message: "Good. Also, maintain a small gratitude journal — it helps calm the mind before sleep.", isSent: false),
    ChatData(message: "That’s a nice idea. Thank you, doctor!", isSent: true)
]


// Sample Chat for RelieBot Chat View
let healthChatData: [ChatData] = [
    ChatData(message: "Hello! I’m your health assistant. How are you feeling today?", isSent: false),
    ChatData(message: "Hi! I’ve been having mild headaches since yesterday.", isSent: true),
    ChatData(message: "I’m sorry to hear that. Are the headaches constant or do they come and go?", isSent: false),
    ChatData(message: "They come and go. Usually worse in the evening.", isSent: true),
    ChatData(message: "Got it. Have you had enough water today? Dehydration can often cause headaches.", isSent: false),
    ChatData(message: "Hmm, not really. I think I only drank one bottle today.", isSent: true),
    ChatData(message: "Try to drink at least 2-3 liters of water daily. Hydration can help a lot.", isSent: false),
    ChatData(message: "Okay, I’ll make sure to do that. Could stress also be a reason?", isSent: true),
    ChatData(message: "Yes, stress and screen time can contribute too. Do you spend long hours on your phone or computer?", isSent: false),
    ChatData(message: "Yes, I work in front of a laptop for around 9 hours a day.", isSent: true),
    
    ChatData(message: "That might explain it. Try following the 20-20-20 rule — every 20 minutes, look 20 feet away for 20 seconds.", isSent: false),
    ChatData(message: "Interesting! I’ll try that. Should I take any medicine for now?", isSent: true),
    ChatData(message: "If it’s mild, try resting in a quiet, dark room and drinking water first. Avoid unnecessary medication.", isSent: false),
    ChatData(message: "Okay. I’ll do that tonight.", isSent: true),
    ChatData(message: "Great. Have you been sleeping well lately?", isSent: false),
    ChatData(message: "Not really. I’ve been sleeping only around 5 hours a night.", isSent: true),
    ChatData(message: "Lack of sleep can worsen headaches too. Try to get 7–8 hours of rest if possible.", isSent: false),
    ChatData(message: "Alright. Should I see a doctor if it continues?", isSent: true),
    ChatData(message: "Yes, if the pain persists for more than 3 days or gets severe, please consult a doctor.", isSent: false),
    ChatData(message: "Got it. Thanks for the advice and care!", isSent: true)
]


struct ChatThread: Identifiable {
    let id = UUID()
    let name: String       // Doctor or Patient name
    let role: String       // "doctor" or "patient"
    let lastMessage: String
    let time: String
    let chatData: [ChatData]
    let profileImage: String
}


let doctorChatThreads: [ChatThread] = [
    ChatThread(
        name: "John Doe",
        role: "patient",
        lastMessage: "Thank you, doctor!",
        time: "10:45 AM",
        chatData: sampleChatData,
        profileImage: "person.fill"
    ),
    ChatThread(
        name: "Priya Sharma",
        role: "patient",
        lastMessage: "Booked appointment for tomorrow.",
        time: "Yesterday",
        chatData: sampleChatData,
        profileImage: "person.fill"
    )
]

let patientChatThreads: [ChatThread] = [
    ChatThread(
        name: "Dr. Mehta",
        role: "doctor",
        lastMessage: "Please follow up next week.",
        time: "9:10 AM",
        chatData: sampleChatData,
        profileImage: "stethoscope"
    ),
    ChatThread(
        name: "Dr. Kapoor",
        role: "doctor",
        lastMessage: "Avoid caffeine after 5 pm.",
        time: "Yesterday",
        chatData: sampleChatData,
        profileImage: "stethoscope"
    )
]


