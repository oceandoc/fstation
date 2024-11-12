const url = r'https?://([\w-]+\.)+[\w-]+(/[\w-./?%&@\$=~#+]*)?';
const phoneNumber = r'[+0]\d+[\d-]+\d';
const email = r'[^@\s]+@([^@\s]+\.)+[^@\W]+';
const duration = r'\b(\d{1,2}:)?(\d{1,2}):(\d{2})\b';
const all = '($url|$duration|$phoneNumber|$email)';
