#ifndef Notifications
#define Notifications

namespace notifications
{
    void setIconBadgeN(int number);
    void increaseIconBadgeN(int number);
    void decreaseIconBadgeN(int number);
    void cancelLocalN();
    void cancelLocalNWithID(int notifid);
    void scheduleLocalN(const char* jsonString);
}

#endif
