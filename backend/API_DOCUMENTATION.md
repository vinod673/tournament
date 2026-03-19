# 🚀 ArenaX Gaming Backend API Documentation

## Base URL
```
http://localhost:5000/api
```

---

## 🔐 Authentication

All protected endpoints require a JWT token in the Authorization header:

```
Authorization: Bearer YOUR_JWT_TOKEN
```

Get the token from Supabase after login:
```javascript
const { data } = await supabase.auth.getSession();
const token = data.session.access_token;
```

---

## 📋 API Endpoints

### Health Check
```http
GET /api/health
```

**Response:**
```json
{
  "status": "OK",
  "message": "ArenaX Gaming API is running",
  "timestamp": "2026-03-19T11:20:19.617Z"
}
```

---

### Get All Tournaments
```http
GET /api/tournaments
```

**Response:**
```json
{
  "success": true,
  "count": 4,
  "data": [
    {
      "id": "uuid",
      "title": "Valorant Championship",
      "game": "Valorant",
      "description": "...",
      "entry_fee": 0,
      "prize_pool": 10000,
      "max_participants": 32,
      "current_participants": 24,
      "status": "upcoming",
      "start_date": "2026-03-25T10:00:00Z",
      "created_at": "2026-03-19T11:20:19.617Z"
    }
  ]
}
```

---

### Get Tournament by ID
```http
GET /api/tournaments/:id
```

**Response:**
```json
{
  "success": true,
  "data": {
    "id": "uuid",
    "title": "Valorant Championship",
    ...
  }
}
```

**404 Error:**
```json
{
  "success": false,
  "error": "Tournament not found"
}
```

---

### Create Tournament (Admin Only)
```http
POST /api/tournaments
Authorization: Bearer TOKEN
Content-Type: application/json

{
  "title": "CS:GO Major",
  "game": "Counter-Strike",
  "description": "Professional CS:GO tournament",
  "entry_fee": 10.00,
  "prize_pool": 50000,
  "max_participants": 16,
  "start_date": "2026-04-10T14:00:00Z",
  "end_date": "2026-04-12T20:00:00Z"
}
```

**Required Fields:**
- `title` (string)
- `game` (string)
- `start_date` (ISO 8601 datetime)

**Optional Fields:**
- `description` (string)
- `entry_fee` (number, default: 0)
- `prize_pool` (number)
- `max_participants` (integer, default: 8)
- `end_date` (ISO 8601 datetime)

**Success Response (201):**
```json
{
  "success": true,
  "message": "Tournament created successfully",
  "data": { ... }
}
```

**Error Responses:**

**400 Bad Request:**
```json
{
  "success": false,
  "error": "Validation failed",
  "message": "Title, game, and start date are required"
}
```

**401 Unauthorized:**
```json
{
  "error": "Unauthorized",
  "message": "Invalid or expired token"
}
```

**403 Forbidden:**
```json
{
  "error": "Forbidden",
  "message": "Admin access required"
}
```

---

### Update Tournament (Admin Only)
```http
PUT /api/tournaments/:id
Authorization: Bearer TOKEN
Content-Type: application/json

{
  "title": "Updated Tournament Name",
  "prize_pool": 75000
}
```

**Note:** Cannot update `created_by` or `current_participants` fields.

**Success Response:**
```json
{
  "success": true,
  "message": "Tournament updated successfully",
  "data": { ... }
}
```

---

### Delete Tournament (Admin Only)
```http
DELETE /api/tournaments/:id
Authorization: Bearer TOKEN
```

**Success Response:**
```json
{
  "success": true,
  "message": "Tournament deleted successfully"
}
```

---

### Join Tournament (Authenticated Users)
```http
POST /api/tournaments/:id/join
Authorization: Bearer TOKEN
```

**Success Response (201):**
```json
{
  "success": true,
  "message": "Successfully joined tournament",
  "data": {
    "tournament_id": "uuid",
    "user_id": "uuid",
    "status": "active",
    "joined_at": "2026-03-19T11:20:19.617Z"
  }
}
```

**Error Responses:**

**400 Bad Request:**
```json
{
  "success": false,
  "error": "Already joined",
  "message": "You have already joined this tournament"
}
```

```json
{
  "success": false,
  "error": "Tournament is full",
  "message": "This tournament has reached maximum capacity"
}
```

**404 Not Found:**
```json
{
  "success": false,
  "error": "Tournament not found"
}
```

---

### Leave Tournament (Authenticated Users)
```http
DELETE /api/tournaments/:id/leave
Authorization: Bearer TOKEN
```

**Success Response:**
```json
{
  "success": true,
  "message": "Successfully left tournament"
}
```

---

### Get Participants (Admin Only)
```http
GET /api/tournaments/:id/participants
Authorization: Bearer TOKEN
```

**Response:**
```json
{
  "success": true,
  "count": 8,
  "data": [
    {
      "id": "uuid",
      "tournament_id": "uuid",
      "user_id": "uuid",
      "joined_at": "2026-03-19T11:20:19.617Z",
      "status": "active",
      "profiles": {
        "id": "uuid",
        "email": "player@example.com",
        "full_name": "John Doe",
        "username": "johndoe"
      }
    }
  ]
}
```

---

## 🔧 Testing with cURL

### Get All Tournaments
```bash
curl http://localhost:5000/api/tournaments
```

### Get Single Tournament
```bash
curl http://localhost:5000/api/tournaments/YOUR_TOURNAMENT_ID
```

### Create Tournament (Admin)
```bash
curl -X POST http://localhost:5000/api/tournaments \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer YOUR_TOKEN" \
  -d '{
    "title": "Test Tournament",
    "game": "Valorant",
    "entry_fee": 5,
    "prize_pool": 1000,
    "max_participants": 8,
    "start_date": "2026-04-01T10:00:00Z"
  }'
```

### Join Tournament
```bash
curl -X POST http://localhost:5000/api/tournaments/YOUR_TOURNAMENT_ID/join \
  -H "Authorization: Bearer YOUR_TOKEN"
```

### Delete Tournament
```bash
curl -X DELETE http://localhost:5000/api/tournaments/YOUR_TOURNAMENT_ID \
  -H "Authorization: Bearer YOUR_TOKEN"
```

---

## 🧪 Testing with PowerShell

### Get All Tournaments
```powershell
Invoke-RestMethod -Uri "http://localhost:5000/api/tournaments" -Method Get
```

### Get Tournament by ID
```powershell
Invoke-RestMethod -Uri "http://localhost:5000/api/tournaments/ID_HERE" -Method Get
```

### Create Tournament (Admin)
```powershell
$body = @{
    title = "PowerShell Test Tournament"
    game = "League of Legends"
    entry_fee = 10
    prize_pool = 5000
    max_participants = 16
    start_date = "2026-05-01T14:00:00Z"
} | ConvertTo-Json

$headers = @{
    "Content-Type" = "application/json"
    "Authorization" = "Bearer YOUR_TOKEN"
}

Invoke-RestMethod -Uri "http://localhost:5000/api/tournaments" `
  -Method Post `
  -Headers $headers `
  -Body $body
```

### Join Tournament
```powershell
$headers = @{
    "Authorization" = "Bearer YOUR_TOKEN"
}

Invoke-RestMethod -Uri "http://localhost:5000/api/tournaments/TOURNAMENT_ID/join" `
  -Method Post `
  -Headers $headers
```

---

## 🎯 Frontend Integration Example

### Using the API Client

```typescript
import { tournamentApi } from '@/lib/api';

// Get all tournaments
const tournaments = await tournamentApi.getAll();
console.log(tournaments.data);

// Join a tournament
try {
  const result = await tournamentApi.join(tournamentId);
  alert(result.message);
} catch (error) {
  console.error('Failed to join:', error.response.data);
}

// Create tournament (Admin)
const newTournament = await tournamentApi.create({
  title: "New Tournament",
  game: "Valorant",
  start_date: "2026-04-01T10:00:00Z"
});
```

---

## 📊 Status Codes Reference

| Code | Meaning | When |
|------|---------|------|
| 200 | OK | Successful GET/PUT request |
| 201 | Created | Successful POST (create/join) |
| 400 | Bad Request | Validation errors, already joined, tournament full |
| 401 | Unauthorized | Missing or invalid token |
| 403 | Forbidden | Insufficient permissions (non-admin) |
| 404 | Not Found | Tournament doesn't exist |
| 500 | Internal Server Error | Database errors, unexpected issues |

---

## 🔒 Security Notes

1. **Token Expiration**: Access tokens expire after 1 hour
   - Use refresh tokens to get new access tokens
   - Frontend handles this automatically via Supabase client

2. **RLS Policies**: Backend respects database RLS policies
   - Even with service role key, policies are enforced

3. **Rate Limiting**: Not implemented yet (future enhancement)
   - Consider adding express-rate-limit

4. **Input Validation**: Basic validation in controllers
   - Consider adding Joi or express-validator for complex rules

---

## 🆘 Troubleshooting

### "Cannot connect to backend"
- Check backend is running: `http://localhost:5000/api/health`
- Verify PORT in .env matches what you're calling
- Check CORS settings if calling from different origin

### "Unauthorized" errors
- Verify token is valid and not expired
- Check Authorization header format: `Bearer TOKEN`
- Ensure token is from same Supabase project

### "Tournament not found"
- Verify tournament ID exists in database
- Check UUID format is correct

### Admin endpoints return 403
- Verify user has 'admin' role in profiles table
- Check authentication middleware is working
- Test with admin account credentials

---

## 📝 Next Steps

### Future Enhancements:
- [ ] Pagination for tournament lists
- [ ] Filtering (by game, status, date range)
- [ ] Search functionality
- [ ] Image upload for tournaments
- [ ] Email notifications on join/leave
- [ ] Real-time updates via webhooks
- [ ] Tournament brackets management
- [ ] Match results tracking

---

**Backend APIs are now fully functional! 🎉**
