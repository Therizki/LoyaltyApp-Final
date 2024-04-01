const request = require('supertest');
const app = require('../index.js'); // Adjust the path according to your app's structure

describe('Authentication API Tests', () => {
  describe('Login API', () => {
    it('should login successfully with correct credentials', async () => {
      const response = await request(app)
        .post('/api/login')
        .send({ username: 'test@example.com', password: 'password123' });
      expect(response.statusCode).toBe(200);
      expect(response.body.message).toBe('Login successful');
      // Add more assertions as necessary
    });

    // Add more tests here for other scenarios
  });

//   describe('Register API', () => {
//     it('should fail registration when user already exists', async () => {
//       const response = await request(app)
//         .post('/api/register')
//         .send({ full_name: 'Test User', email: 'test@example.com', password: 'password123' });
//       expect(response.statusCode).toBe(400);
//       expect(response.body.message).toBe('User already exists with this email');
//       // Add more assertions as necessary
//     });

//   });
});
