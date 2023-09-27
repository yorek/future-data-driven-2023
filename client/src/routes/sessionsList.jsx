import { useLoaderData } from "react-router-dom";
import { getSessions } from "../sessions";

export async function loader() {
    const sessions  = await getSessions();
    return { sessions };
}

export default function SessionsList() {
    const { sessions } = useLoaderData();

    return (
        <>           
        <div id="sessions" className={navigation.state === "loading" ? "loading" : ""}>
            {sessions.length ? (
                <ul>
                    {sessions.map((session) => (
                        <li key={session.id}>
                            <h2>{session.title}</h2>
                            <h4>{session.speaker.fullname}</h4>
                            <div id="abstract">
                                {session.abstract}
                            </div>
                        </li>
                    ))}
                </ul>
            ) : ""} 
        </div>
        </>
    );
}