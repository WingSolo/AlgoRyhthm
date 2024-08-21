document.addEventListener('DOMContentLoaded', () => {
    const loginLink = document.getElementById('login-link');
    const companyLink = document.getElementById('company-link');
    const homeLink = document.getElementById('home-link');
    const leftPanel = document.getElementById('left-panel');
    const rightPanel = document.getElementById('right-panel');

    function showLoginSignup() {
        leftPanel.innerHTML = `
            <div class="auth-buttons">
                <button id="show-login">로그인</button>
                <button id="show-signup">회원 가입</button>
            </div>
        `;
        document.getElementById('show-login').addEventListener('click', () => {
            rightPanel.innerHTML = '<iframe src="login.html" style="width:100%; height:100%; border:none;"></iframe>';
        });

        document.getElementById('show-signup').addEventListener('click', () => {
            rightPanel.innerHTML = '<iframe src="signup.html" style="width:100%; height:100%; border:none;"></iframe>';
        });
    }

    function showCompanyInfo() {
        leftPanel.innerHTML = `
            <div class="info-buttons">
                <button id="show-company-info">회사소개</button>
                <button id="show-case-studies">분석사례</button>
            </div>
        `;
        document.getElementById('show-company-info').addEventListener('click', () => {
            rightPanel.innerHTML = `
                <h1>회사소개</h1>
                <p>여기에 회사소개 내용이 들어갑니다.</p>
            `;
        });

        document.getElementById('show-case-studies').addEventListener('click', () => {
            rightPanel.innerHTML = `
                <div class="case-study-buttons">
                    <button id="case-study-heat-treatment">열처리</button>
                    <button id="case-study-casting">주조</button>
                </div>
                <div id="case-study-content" class="case-study-content"></div>
            `;
            document.getElementById('case-study-heat-treatment').addEventListener('click', () => {
                document.getElementById('case-study-content').innerHTML = `
                    <h2>열처리</h2>
                    <p>여기에 열처리에 대한 분석사례 내용이 들어갑니다.</p>
                `;
            });

            document.getElementById('case-study-casting').addEventListener('click', () => {
                document.getElementById('case-study-content').innerHTML = `
                    <h2>주조</h2>
                    <p>여기에 주조에 대한 분석사례 내용이 들어갑니다.</p>
                `;
            });
        });
    }

    function resetToHome() {
        if (leftPanel && rightPanel) {
            // Update content for the left panel
            leftPanel.innerHTML = `
                <h1 class="company">데이터 분석 전문 회사</h1>
                <h1 class="moving-text">◐알고리듬♪</h1>
            `;
    
            // Update content for the right panel
            rightPanel.innerHTML = `
                <h1>알고리듬에 오신 것을 환영합니다.</h1>
                <div class="image-container">
                    <img src="algo.gif" alt="Algo" class="gif-image">
                    <img src="rhythm.gif" alt="Rhythm" class="gif-image">
                </div>
            `;
        } else {
            console.error('Error: leftPanel or rightPanel is not defined.');
        }
    }
    


    loginLink.addEventListener('click', (event) => {
        event.preventDefault();
        resetToHome(); // Clear any other content
        showLoginSignup();
    });

    companyLink.addEventListener('click', (event) => {
        event.preventDefault();
        resetToHome(); // Clear any other content
        showCompanyInfo();
    });

    homeLink.addEventListener('click', (event) => {
        event.preventDefault();
        resetToHome();
    });

    // Show home content by default on page load
    resetToHome();
});
