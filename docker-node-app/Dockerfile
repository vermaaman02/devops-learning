# Base image: official Node.js image (lightweight)
FROM node:18-alpine
# node:18-alpine = Node 18 + Alpine Linux (chhota & fast)

# Container ke andar working directory set karo
WORKDIR /app
# Aage ke saare commands /app se chalenge

# Sirf package.json copy karo (cache ke liye best practice)
COPY package.json ./
# ./ ka matlab: WORKDIR wale /app me copy hoga

# Dependencies install karo (agar kuch ho)
RUN npm install
# Abhi koi dependency nahi, lekin pattern sahi hai future ke liye

# Baaki code copy karo
COPY server.js ./

# App container ke andar port 3000 pe chalegi
EXPOSE 3000

# Container start hone pe ye command chalegi
CMD ["npm", "start"]
# Yani: npm start → node server.js
