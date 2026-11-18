# Use Python 3.13 for compatibility
FROM apify/actor-python:3.13

# Copy requirements first
COPY requirements.txt ./

# Force clean install with exact versions, ignore pre-installed packages
RUN pip install --no-cache-dir --force-reinstall -r requirements.txt

# Copy the source code
COPY . ./

# Run the Actor
CMD ["python", "-m", "src"]



# # Use a single base image
# FROM apify/actor-python:3.13

# # Copy and install Python deps once
# COPY requirements.txt /tmp/requirements.txt
# RUN pip install --no-cache-dir -r /tmp/requirements.txt

# # Install system packages required for Chrome, chromedriver and networking
# RUN apt-get update \
#  && apt-get install -y --no-install-recommends wget curl gnupg unzip ca-certificates chromium-driver \
#  && rm -rf /var/lib/apt/lists/*

# # Add Google Chrome repo and install stable Chrome
# RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - \
#  && sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google.list' \
#  && apt-get update \
#  && apt-get install -y --no-install-recommends google-chrome-stable \
#  && rm -rf /var/lib/apt/lists/*

# # Link chromedriver to standard location
# RUN ln -s /usr/bin/chromedriver /usr/local/bin/chromedriver || true

# # Install any additional Python packages
# RUN pip install --no-cache-dir selenium axe-selenium-python

# # Copy source and compile
# COPY . ./
# RUN python3 -m compileall -q src/

# # Create non-root user and set ownership
# RUN useradd --create-home apify && chown -R apify:apify ./
# USER apify

# # Default command
# CMD ["python3", "-m", "src"]