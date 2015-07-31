#ifndef Notifications
#define Notifications

namespace notifications
{
    void setIconBadgeN(int number);
    void increaseIconBadgeN(int number);
    void decreaseIconBadgeN(int number);
    void cancelLocalN();
    void scheduleLocalN(const char* message, int time, int repeat);
}

#endif
