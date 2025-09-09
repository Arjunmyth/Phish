from playwright.sync_api import sync_playwright

GMAIL = "jrarjun211@gmail.com"

def run_bot():
    with sync_playwright() as p:
        browser = p.chromium.launch(headless=True)
        page = browser.new_page()

        # Open the reset page
        page.goto("https://www.kycport.com/login/email?reason=reset")

        # 🔹 Wait until the Email input is ready (Cloudflare finished)
        page.wait_for_selector("input[type='email']", timeout=7000)

        # Enter Gmail
        page.fill("input[type='email']", GMAIL)

        # Click Reset Password
        page.click("button[type='submit']")

        # Wait few seconds for backend to process
        page.wait_for_timeout(5000)

        browser.close()

    print("Password reset request sent ✅")

if __name__ == "__main__":
    run_bot()