from flask import Flask, render_template_string
import subprocess
import os
from datetime import datetime

app = Flask(__name__)

HTML_TEMPLATE = """
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Prvtspyyy404 | Dashboard</title>
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Orbitron:wght@400;900&display=swap');
        body { background: #050505; color: #00ffff; font-family: 'Orbitron', sans-serif; text-align: center; margin: 0; padding: 0; }
        
        /* Glitch Animation */
        .glitch { font-size: 4rem; font-weight: 900; text-transform: uppercase; position: relative; margin-top: 10vh;
                  text-shadow: 0.05em 0 0 #00fffc, -0.03em -0.04em 0 #fc00ff, 0.025em 0.04em 0 #fffc00;
                  animation: glitch 725ms infinite; }
        @keyframes glitch {
            0% { text-shadow: 0.05em 0 0 #00fffc, -0.03em -0.04em 0 #fc00ff, 0.025em 0.04em 0 #fffc00; }
            15% { text-shadow: 0.05em 0 0 #00fffc, -0.03em -0.04em 0 #fc00ff, 0.025em 0.04em 0 #fffc00; }
            16% { text-shadow: -0.05em -0.025em 0 #00fffc, 0.025em 0.035em 0 #fc00ff, -0.05em -0.05em 0 #fffc00; }
            49% { text-shadow: -0.05em -0.025em 0 #00fffc, 0.025em 0.035em 0 #fc00ff, -0.05em -0.05em 0 #fffc00; }
            50% { text-shadow: 0.025em 0.05em 0 #00fffc, 0.05em 0 0 #fc00ff, 0 -0.05em 0 #fffc00; }
            99% { text-shadow: 0.025em 0.05em 0 #00fffc, 0.05em 0 0 #fc00ff, 0 -0.05em 0 #fffc00; }
            100% { text-shadow: -0.025em 0 0 #00fffc, -0.025em -0.025em 0 #fc00ff, -0.025em -0.05em 0 #fffc00; }
        }

        .status-container { border: 2px solid #00ffff; display: inline-block; padding: 30px; margin-top: 30px; 
                           box-shadow: 0 0 20px #00ffff; background: rgba(0,255,255,0.05); border-radius: 10px; }
        .info { text-align: left; font-size: 1.1rem; line-height: 1.8; }
        .label { color: #ff00ff; font-weight: bold; }
        .value { color: #fff; text-shadow: 0 0 5px #fff; }
        .active { color: #0f0; animation: blinker 1s linear infinite; }
        @keyframes blinker { 50% { opacity: 0; } }
        
        #clock { font-size: 1.2rem; color: #ff00ff; margin-bottom: 20px; }
        .footer { position: fixed; bottom: 15px; width: 100%; font-size: 0.75rem; color: #666; }
    </style>
</head>
<body>
    <h1 class="glitch">Prvtspyyy404</h1>
    <p class="active">SERVER ACTIVE AND READY TO USE</p>
    
    <div class="status-container">
        <div id="clock">Loading Time...</div>
        <div class="info">
            <span class="label">PROTOCOL:</span> <span class="value">SSH Over WebSocket (TLS)</span><br>
            <span class="label">SERVER NAME:</span> <span class="value">{{ svc_name }}</span><br>
            <span class="label">USER & PASS:</span> <span class="value">root | prvtspyyy</span><br>
            <span class="label">STATUS:</span> <span style="color:#0f0">● ONLINE</span><br>
            <span class="label">SERVER IP:</span> <span class="value">{{ ip }}</span>
        </div>
    </div>

    <div class="footer">
        CONTACT Saeka Tojirp on Facebook for concerns and complains
    </div>

    <script>
        function updateTime() {
            const now = new Date();
            document.getElementById('clock').innerHTML = now.toUTCString();
        }
        setInterval(updateTime, 1000);
        updateTime();
    </script>
</body>
</html>
"""

@app.route('/')
def index():
    svc = os.getenv('K_SERVICE', 'Prvtspyyy-SSH')
    # Use fallback if hostname command fails in some environments
    try:
        ip = subprocess.check_output(["hostname", "-i"]).decode('utf-8').strip()
    except:
        ip = "Dynamic GCP IP"
    return render_template_string(HTML_TEMPLATE, svc_name=svc, ip=ip)

if __name__ == "__main__":
    port = int(os.environ.get('PORT', 8080))
    app.run(host='0.0.0.0', port=port)
