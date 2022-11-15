Then /I should be redirected to the Google Login Page/ do
    page.should have_content("Choose an account")
end

And /I perform Google SSO/ do
    begin
        click_button "Log In with Google"
    rescue ActionController::RoutingError
        expect(page.current_url).to include("accounts.google.com")
    end
end