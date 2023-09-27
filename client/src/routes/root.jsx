import { useLoaderData, Outlet } from "react-router-dom";
import { getSessionsCount } from "../sessions";
import { getUserInfo } from "../user";

export async function loader() {
  const sessionsCount = await getSessionsCount();
  const userInfo = await getUserInfo();
  return { userInfo, sessionsCount };
}

export default function Root() {
  const { userInfo, sessionsCount } = useLoaderData();

  return (
    <>
      <div id="header">
        <h1>Session Navigator</h1>
        <p>There are {sessionsCount} session stored.</p>
      </div>
      <div id="user-info">
          { userInfo ?
            <span>Welcome {userInfo.userDetails}! [<a href="/.auth/logout">Logout</a>] </span>
            :
            <a href="/.auth/login/github">Login with GitHub</a>
          }
        </div>
      <div>
        <Outlet /> 
      </div>
    </>
  );
}