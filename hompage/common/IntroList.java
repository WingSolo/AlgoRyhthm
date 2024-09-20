package common;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

public class IntroList {

    private List<Intro> introList;

    // 기본 생성자
    public IntroList() {
        this.introList = new ArrayList<>();
    }

    // 분석내역 목록 반환
    public List<Intro> getIntroList() {
        return introList;
    }

    // 새로운 Intro 객체 추가
    public void addIntro(Intro intro) {
        this.introList.add(intro);
    }

    // 공지사항 목록 초기화
    public void clearIntro() {
        this.introList.clear();
    }

    // 이메일로 특정 Intro 객체 찾기
    public Optional<Intro> findIntroByEmail(String email) {
        return introList.stream()
                        .filter(intro -> intro.getEmail().equalsIgnoreCase(email))
                        .findFirst();
    }

    // 전체 Intro 객체 수 반환
    public int getIntroCount() {
        return introList.size();
    }
}
