package common;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

public class NoticeList {

    private List<Notice> noticeList;

    // 기본 생성자
    public NoticeList() {
        this.noticeList = new ArrayList<>();
    }

    // 공지사항 목록 반환
    public List<Notice> getNoticeList() {
        return noticeList;
    }

    // 공지사항 추가
    public void addNotice(Notice notice) {
        if (notice != null) {
            this.noticeList.add(notice);
        }
    }

    // 공지사항 삭제 (공지사항 번호로)
    public boolean removeNotice(int num) {
        return noticeList.removeIf(notice -> notice.getNum() == num);
    }

    // 공지사항 검색 (공지사항 번호로)
    public Optional<Notice> findNoticeByNum(int num) {
        return noticeList.stream()
                         .filter(notice -> notice.getNum() == num)
                         .findFirst();
    }

    // 공지사항 제목으로 검색
    public List<Notice> findNoticesByTitle(String title) {
        List<Notice> foundNotices = new ArrayList<>();
        for (Notice notice : noticeList) {
            if (notice.getTitle().contains(title)) {
                foundNotices.add(notice);
            }
        }
        return foundNotices;
    }

    // 공지사항 목록 초기화
    public void clearNotices() {
        this.noticeList.clear();
    }

    @Override
    public String toString() {
        StringBuilder sb = new StringBuilder();
        for (Notice notice : noticeList) {
            sb.append(notice.toString()).append("\n");
        }
        return sb.toString();
    }
}
