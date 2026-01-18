//const express = require("express");
//const mongoose = require("mongoose");
//
//const app = express();
//app.use(express.json());
//
//// ==================
//// DATABASE
//// ==================
//mongoose.connect("mongodb://127.0.0.1:27017/reliefnet")
//  .then(() => console.log("✅ MongoDB Connected"))
//  .catch(err => console.log(err));
//
//// ==================
//// SCHEMAS
//// ==================
//const PatientSchema = new mongoose.Schema({
//  email: { type: String, unique: true },
//  name: String,
//  phone: String,
//  location: String,
//  photoUrl: String
//});
//
//const DoctorSchema = new mongoose.Schema({
//  email: { type: String, unique: true },
//  name: String,
//  specialization: String,
//  experience: String,
//  price: Number,
//  location: String,
//  rating: { type: Number, default: 0 }
//});
//
//const AvailabilitySchema = new mongoose.Schema({
//  doctorId: mongoose.Schema.Types.ObjectId,
//  date: Date,
//  slots: [{
//    startTime: String,
//    endTime: String,
//    isBooked: { type: Boolean, default: false }
//  }]
//});
//
//const BookingSchema = new mongoose.Schema({
//  patientId: mongoose.Schema.Types.ObjectId,
//  doctorId: mongoose.Schema.Types.ObjectId,
//  appointmentDate: Date,
//  appointmentTime: String,
//  status: { type: String, default: "pending" }
//});
//
//// ==================
//// MODELS
//// ==================
//const Patient = mongoose.model("Patient", PatientSchema);
//const Doctor = mongoose.model("Doctor", DoctorSchema);
//const Availability = mongoose.model("Availability", AvailabilitySchema);
//const Booking = mongoose.model("Booking", BookingSchema);
//
//// ==================
//// PATIENT APIs
//// ==================
//app.post("/api/patient/create", async (req, res) => {
//  const { email, name, phone, location, photoUrl } = req.body;
//
//  let patient = await Patient.findOne({ email });
//  if (!patient) {
//    patient = await Patient.create({ email, name, phone, location, photoUrl });
//  }
//
//  res.json(patient);
//});
//
//app.get("/api/patient/:id", async (req, res) => {
//  res.json(await Patient.findById(req.params.id));
//});
//
//// ==================
//// DOCTOR APIs
//// ==================
//app.post("/api/doctor/create", async (req, res) => {
//  res.json(await Doctor.create(req.body));
//});
//
//app.get("/api/doctors", async (req, res) => {
//  res.json(await Doctor.find());
//});
//
//// ==================
//// AVAILABILITY
//// ==================
//app.post("/api/doctor/availability", async (req, res) => {
//  res.json(await Availability.create(req.body));
//});
//
//app.get("/api/doctor/:id/slots", async (req, res) => {
//  const data = await Availability.find({
//    doctorId: req.params.id,
//    "slots.isBooked": false
//  });
//  res.json(data);
//});
//
//// ==================
//// BOOKINGS
//// ==================
//app.post("/api/booking/create", async (req, res) => {
//  const booking = await Booking.create(req.body);
//
//  await Availability.updateOne(
//    {
//      doctorId: booking.doctorId,
//      date: booking.appointmentDate,
//      "slots.startTime": booking.appointmentTime
//    },
//    { $set: { "slots.$.isBooked": true } }
//  );
//
//  res.json(booking);
//});
//
//app.get("/api/patient/:id/bookings", async (req, res) => {
//  res.json(await Booking.find({ patientId: req.params.id }));
//});
//
//// ==================
//// SERVER
//// ==================
//app.listen(5000, () => {
//  console.log("🚀 Server running on http://localhost:5000");
//});
