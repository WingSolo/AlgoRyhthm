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

    

    // 공지사항 목록 초기화
    public void clearIntro() {
        this.introList.clear();
    }


}
