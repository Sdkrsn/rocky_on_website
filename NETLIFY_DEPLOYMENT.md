# 🚀 Netlify Deployment Guide for Rocky Website

This guide will help you deploy your Rocky website on Netlify's global CDN.

## Prerequisites

✅ GitHub account  
✅ Netlify account (free at https://netlify.com)  
✅ Your project pushed to GitHub  
✅ `.env` file with `GEMINI_API_KEY`

---

## Step 1: Prepare Your Project for Deployment

### Files Already Created:
- ✅ `netlify.toml` - Build configuration
- ✅ `netlify_server.py` - Flask wrapper for Netlify
- ✅ `requirements_web.txt` - Dependencies updated

### What You Need to Do:

1. **Push to GitHub** (if not already):
```bash
git init
git add .
git commit -m "Setup Rocky for Netlify deployment"
git remote add origin https://github.com/YOUR_USERNAME/your-repo-name.git
git branch -M main
git push -u origin main
```

---

## Step 2: Deploy on Netlify

### Option A: Using Netlify CLI (Recommended)

1. **Install Netlify CLI:**
```bash
npm install -g netlify-cli
```

2. **Login to Netlify:**
```bash
netlify login
```

3. **Deploy your site:**
```bash
netlify deploy --prod
```

4. **Set environment variables:**
   - Go to Netlify Dashboard → Your Site → Site Settings → Build & Deploy → Environment
   - Add: `GEMINI_API_KEY` = your API key
   - Rebuild the site

### Option B: Using Netlify Dashboard (Easier)

1. **Go to [netlify.com](https://netlify.com)**
2. **Click "Add new site" → "Import an existing project"**
3. **Select GitHub** and authorize
4. **Choose your repository** (randomwalk/buddy)
5. **Configure build settings:**
   - Build command: `pip install -r requirements_web.txt && python -m pip install gunicorn`
   - Publish directory: `.`
   - ✅ Click "Deploy"

6. **Add environment variables:**
   - Go to Site Settings → Build & Deploy → Environment variables
   - Add `GEMINI_API_KEY` = your actual API key
   - Trigger a rebuild

---

## Step 3: Set Environment Variables on Netlify

Your app needs the `GEMINI_API_KEY` to work with the chat API.

### Steps:
1. **In Netlify Dashboard:**
   - Site Settings → Build & Deploy → Environment variables
   - Click "Edit variables"
   - Add a new variable:
     - Key: `GEMINI_API_KEY`
     - Value: `your-actual-api-key-here`
   - Save

2. **Trigger a rebuild:**
   - Deploys → Trigger deploy → Clear cache and redeploy

---

## Step 4: Configure Custom Domain (Optional)

1. **In Netlify Dashboard:**
   - Site Settings → Domain management
   - Click "Add domain"
   - Enter your custom domain (e.g., `rocky.yourcompany.com`)
   - Configure DNS records with your domain provider

2. **Enable HTTPS:**
   - Netlify automatically provisions SSL certificates
   - Check Site Settings → HTTPS

---

## Step 5: Test Your Deployment

Once deployment is complete:

1. **Visit your Netlify URL:** `https://your-site-name.netlify.app`
2. **Test Rocky:**
   - Rocky should walk across the page
   - Click Rocky to open chat
   - Send a message
   - Wait for response from Gemini API

3. **Check Performance:**
   - Netlify Analytics → Performance
   - Monitor build logs under Deploys → Deploy log

---

## Troubleshooting

### Build Fails with "ModuleNotFoundError"
**Fix:** Ensure `requirements_web.txt` has all dependencies
```
pip install flask flask-cors python-dotenv gunicorn google-generativeai
```

### Chat API returns errors
**Fix:** Check environment variables
```
netlify env:list
netlify env:set GEMINI_API_KEY "your-key-here"
```

### Rocky sprites not loading
**Fix:** Verify sprite files exist in `sprites/` folder
```
sprites/
├── walkleft1.png
├── walkleft2.png
├── stand.png
└── jazz1.png
```

### Deployment stuck or timing out
**Fix:** Check build logs in Netlify Dashboard:
- Deploys → Click latest deploy → Deploy log
- Look for error messages
- Common issue: Python dependencies taking too long

---

## Monitoring & Maintenance

### Check Build Status
1. Netlify Dashboard → Deploys
2. Green checkmark = successful
3. Red X = build failed (click to see logs)

### View Logs
- **Build logs:** Deploys → Deploy log
- **Server logs:** Functions → Logs
- **Analytics:** Analytics dashboard

### Automatic Deployments
Every push to GitHub automatically triggers a rebuild:
```bash
git push origin main  # Automatically deploys!
```

---

## Environment Setup Reference

### Required Variables:
| Variable | Value | Where to Get |
|----------|-------|--------------|
| `GEMINI_API_KEY` | Your Gemini API key | [Google AI Studio](https://aistudio.google.com) |

### Optional Variables:
| Variable | Default | Purpose |
|----------|---------|---------|
| `FLASK_ENV` | production | Set to 'development' for debug mode |
| `PORT` | 5000 | Server port (Netlify manages this) |

---

## Performance Tips

### 1. Enable Caching
Your `netlify.toml` already includes cache headers for:
- Static files (sprites): 1 year cache
- HTML: 1 hour cache

### 2. Use Netlify Edge Functions (Advanced)
For faster response times, consider migrating chat to edge functions.

### 3. Monitor API Costs
- Gemini API has free tier (limited calls)
- Add request logging to track usage
- Consider rate limiting for production

---

## Next Steps

1. ✅ Push code to GitHub
2. ✅ Connect repo to Netlify
3. ✅ Add `GEMINI_API_KEY` environment variable
4. ✅ Deploy and test
5. ✅ Monitor performance
6. ✅ (Optional) Connect custom domain
7. ✅ (Optional) Set up analytics

---

## Useful Netlify Commands

```bash
# Login to Netlify
netlify login

# List your sites
netlify sites:list

# Deploy (staging)
netlify deploy

# Deploy to production
netlify deploy --prod

# Check build logs
netlify builds

# Set environment variable
netlify env:set GEMINI_API_KEY "your-key"

# View environment variables
netlify env:list
```

---

## Support Resources

- **Netlify Docs:** https://docs.netlify.com
- **Flask Deployment:** https://flask.palletsprojects.com/en/stable/deploying/
- **Netlify Functions:** https://docs.netlify.com/functions/overview/
- **Environment Variables:** https://docs.netlify.com/configure-builds/environment-variables/

---

## Summary

Your Rocky website is ready for deployment! The `netlify.toml` configuration handles:
- ✅ Python build environment
- ✅ Dependency installation
- ✅ Flask app serving
- ✅ API routing (`/api/chat`)
- ✅ Static file serving (`/sprites`)
- ✅ Security headers
- ✅ Caching rules

**Next action:** Push to GitHub, then deploy on Netlify! 🚀
