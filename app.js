import { initializeApp } from 'firebase/app';
import { getFirestore } from 'firebase/firestore';
// Initialize Firebase
const firebaseConfig = {
    // Add your Firebase configuration details here.
    apiKey: "AIzaSyBNY81NI5oCN-G5XGnbbCcPVFkW8A-MxJM",
    authDomain: "monkey-food-6128a.firebaseapp.com",
    projectId: "monkey-food-6128a",
    storageBucket: "monkey-food-6128a.appspot.com",
    messagingSenderId: "105092736301",
    appId: "1:105092736301:web:11746bd5affa9166b8dfa4"

  };
  const app = initializeAppn(firebaseConfig);
  firebase.initializeApp(firebaseConfig);

  const db = firebase.firestore();
  const foodForm = document.getElementById('foodForm');
  const restaurantSelect = document.getElementById('restaurant');
  const newRestaurantInput = document.getElementById('newRestaurant');
  const addRestaurantButton = document.getElementById('addRestaurant');
  
  addRestaurantButton.addEventListener('click', () => {
    const newRestaurant = newRestaurantInput.value.trim();
    if (newRestaurant) {
      // Create a new option element and add it to the select dropdown
      const option = document.createElement('option');
      option.value = newRestaurant;
      option.text = newRestaurant;
      restaurantSelect.add(option);
  
      // Clear the input field
      newRestaurantInput.value = '';
    }
  });
  
  foodForm.addEventListener('submit', (e) => {
    e.preventDefault();
  
    // Get form values
    const category = document.getElementById('category').value;
    const cuisine = document.getElementById('cuisine').value;
    const name = document.getElementById('name').value;
    const photoUrl = document.getElementById('photoUrl').value;
    const price = parseInt(document.getElementById('price').value);
    const restaurant = Array.from(restaurantSelect.selectedOptions)
      .map((option) => option.value);
    const vegNonveg = document.getElementById('vegNonveg').value;
    const image = document.getElementById('image').files[0];
  
    // Perform image upload to storage
    const storageRef = firebase.storage().ref();
    const imageRef = storageRef.child(image.name);
    const uploadTask = imageRef.put(image);
  
    uploadTask.on(
      'state_changed',
      null,
      (error) => {
        console.error('Error uploading image:', error);
      },
      () => {
        // Image upload successful, get the download URL
        uploadTask.snapshot.ref.getDownloadURL().then((imageUrl) => {
          // Create a new food item document in Firestore
          db.collection('foodItems').add({
            category,
            cuisine,
            name,
            photoUrl,
            price,
            restaurant,
            vegNonveg,
            imageUrl,
          })
            .then(() => {
              console.log('Food item added successfully!');
              foodForm.reset();
            })
            .catch((error) => {
              console.error('Error adding food item: ', error);
            });
        });
      }
    );
  });