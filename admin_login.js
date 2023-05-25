import { initializeApp } from "https://www.gstatic.com/firebasejs/9.22.0/firebase-app.js";
// Initialize Firebase
const firebaseConfig = {
    // Add your Firebase configuration here
    apiKey: "AIzaSyBNY81NI5oCN-G5XGnbbCcPVFkW8A-MxJM",
    authDomain: "monkey-food-6128a.firebaseapp.com",
    projectId: "monkey-food-6128a",
    storageBucket: "monkey-food-6128a.appspot.com",
    messagingSenderId: "105092736301",
    appId: "1:105092736301:web:11746bd5affa9166b8dfa4"
  };
  const app = initializeApp(firebaseConfig);
  firebase.initializeApp(firebaseConfig);
  
  // Get a reference to the Firebase Authentication service
  const auth = firebase.auth();
  
  // Handle login form submission
  const loginForm = document.getElementById('loginForm');
  const errorDisplay = document.getElementById('error');
  const resetPasswordMsg = document.getElementById('resetPasswordMsg');
  const resetPasswordLink = document.getElementById('resetPasswordLink');
  
  loginForm.addEventListener('submit', (e) => {
    e.preventDefault();
  
    const email = document.getElementById('email').value;
    const password = document.getElementById('password').value;
    // const adminID = document.getElementById('AdminID').value;
  
    // Sign in with email and password
    auth.signInWithEmailAndPassword(email, password)
      .then((userCredential) => {
        // Successful login
        console.log('Login successful!');
        window.location.href = 'admin.html'; // Redirect to the admin page
      })
      .catch((error) => {
        // Error occurred during login
        console.error('Login error:', error);
        errorDisplay.textContent = 'Invalid credentials. Please try again.'; // Show an error message to the user
      });
  });
  
  // Handle password reset link click
  resetPasswordLink.addEventListener('click', (e) => {
    e.preventDefault();
  
    const email = document.getElementById('email').value;
  
    // Send password reset email
    auth.sendPasswordResetEmail(email)
      .then(() => {
        // Password reset email sent successfully
        resetPasswordMsg.textContent = 'Password reset email has been sent. Please check your inbox.'; // Show a success message to the user
      })
      .catch((error) => {
        // Error occurred while sending password reset email
        console.error('Password reset error:', error);
        errorDisplay.textContent = 'Error sending password reset email. Please try again.'; // Show an error message to the user
      });
  });
  