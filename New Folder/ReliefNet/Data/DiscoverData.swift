//
//  DoctorData.swift
//  ReliefNet
//
//  Created by Ayush Singh on 06/10/25.
//

import Foundation

struct DoctorData: Identifiable {
    var id = UUID()
    var name : String
    var role : String
    var experience : Int
    var price : Int
    var rating : Double
    var reviews : Int
    var category : String
    var image : String
    var about : String
}

// Sample Data
let doctorsData: [DoctorData] = [
    // MARK: - Psychologists
    DoctorData(
        name: "Dr. Priya Sharma",
        role: "Clinical Psychologist",
        experience: 8,
        price: 1200,
        rating: 4.9,
        reviews: 124,
        category: "Psychologist",
        image: "doctor1",
        about: "As a clinical psychologist, I specialize in helping individuals overcome anxiety and depression using evidence-based therapies. My focus is on building trust and helping you rediscover balance and confidence."
    ),
    DoctorData(
        name: "Dr. Rohan Mehta",
        role: "Counselling Psychologist",
        experience: 6,
        price: 1000,
        rating: 4.7,
        reviews: 98,
        category: "Psychologist",
        image: "doctor2",
        about: "I’m passionate about helping clients deal with relationship stress, low motivation, and burnout through empathetic and practical counseling sessions."
    ),
    DoctorData(
        name: "Dr. Anjali Verma",
        role: "Child Psychologist",
        experience: 9,
        price: 1300,
        rating: 4.8,
        reviews: 152,
        category: "Psychologist",
        image: "doctor3",
        about: "With a decade of experience in child and adolescent therapy, I help children manage emotional regulation, ADHD, and learning difficulties in a safe, nurturing environment."
    ),
    DoctorData(
        name: "Dr. Mehul Desai",
        role: "Behavioral Psychologist",
        experience: 10,
        price: 1500,
        rating: 4.8,
        reviews: 178,
        category: "Psychologist",
        image: "doctor10",
        about: "My expertise lies in understanding behavioral patterns and using CBT and DBT techniques to help clients manage anger, anxiety, and self-destructive habits."
    ),
    DoctorData(
        name: "Dr. Sneha Chatterjee",
        role: "Clinical Psychologist",
        experience: 7,
        price: 1100,
        rating: 4.6,
        reviews: 102,
        category: "Psychologist",
        image: "doctor11",
        about: "I work with individuals and couples to manage stress, improve communication, and build stronger emotional resilience."
    ),

    // MARK: - Psychiatrists
    DoctorData(
        name: "Dr. Arvind Gupta",
        role: "Psychiatrist",
        experience: 12,
        price: 1800,
        rating: 4.9,
        reviews: 210,
        category: "Psychiatrist",
        image: "doctor4",
        about: "I specialize in diagnosing and treating mood disorders, anxiety, and PTSD. I believe in a balanced approach that integrates medication management with therapy."
    ),
    DoctorData(
        name: "Dr. Sneha Iyer",
        role: "Consultant Psychiatrist",
        experience: 10,
        price: 1600,
        rating: 4.8,
        reviews: 176,
        category: "Psychiatrist",
        image: "doctor5",
        about: "My approach combines modern psychiatric medicine with compassionate communication, ensuring patients feel heard and supported during their healing journey."
    ),
    DoctorData(
        name: "Dr. Rahul Sinha",
        role: "Neuropsychiatrist",
        experience: 14,
        price: 2000,
        rating: 4.9,
        reviews: 198,
        category: "Psychiatrist",
        image: "doctor6",
        about: "I work with individuals facing neurological and psychiatric challenges such as bipolar disorder, OCD, and chronic insomnia, aiming for holistic mental well-being."
    ),
    DoctorData(
        name: "Dr. Pooja Nair",
        role: "Child & Adolescent Psychiatrist",
        experience: 11,
        price: 1700,
        rating: 4.8,
        reviews: 164,
        category: "Psychiatrist",
        image: "doctor12",
        about: "I focus on early intervention and therapy for children and teens struggling with anxiety, ADHD, and emotional dysregulation."
    ),
    DoctorData(
        name: "Dr. Manish Kulkarni",
        role: "Geriatric Psychiatrist",
        experience: 16,
        price: 1900,
        rating: 4.7,
        reviews: 142,
        category: "Psychiatrist",
        image: "doctor13",
        about: "I specialize in providing psychiatric care for older adults, focusing on dementia, depression, and age-related cognitive issues."
    ),

    // MARK: - Therapists
    DoctorData(
        name: "Meera Joshi",
        role: "Cognitive Behavioral Therapist",
        experience: 7,
        price: 900,
        rating: 4.6,
        reviews: 87,
        category: "Therapist",
        image: "doctor7",
        about: "I help clients identify and reshape negative thinking patterns through structured CBT sessions, empowering them to achieve lasting emotional growth."
    ),
    DoctorData(
        name: "Raj Malhotra",
        role: "Mindfulness & Wellness Therapist",
        experience: 5,
        price: 800,
        rating: 4.7,
        reviews: 74,
        category: "Therapist",
        image: "doctor8",
        about: "My goal is to bring peace and clarity to clients’ lives through mindfulness, meditation, and lifestyle coaching grounded in positive psychology."
    ),
    DoctorData(
        name: "Dr. Neha Kapoor",
        role: "Trauma Recovery Therapist",
        experience: 9,
        price: 1100,
        rating: 4.8,
        reviews: 133,
        category: "Therapist",
        image: "doctor9",
        about: "I specialize in trauma-focused therapy and emotional resilience coaching, helping individuals rebuild trust and reconnect with their inner strength."
    ),
    DoctorData(
        name: "Anita Fernandes",
        role: "Art Therapist",
        experience: 6,
        price: 950,
        rating: 4.7,
        reviews: 91,
        category: "Therapist",
        image: "doctor14",
        about: "Through art and creative expression, I help clients process emotions and develop self-awareness in a calm, non-verbal way."
    ),
    DoctorData(
        name: "Sanjay Patel",
        role: "Family & Relationship Therapist",
        experience: 8,
        price: 1000,
        rating: 4.8,
        reviews: 115,
        category: "Therapist",
        image: "doctor15",
        about: "I guide couples and families to communicate effectively, rebuild trust, and resolve long-standing conflicts in a healthy, supportive environment."
    )
]
