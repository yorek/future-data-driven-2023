import { ApolloClient, InMemoryCache } from '@apollo/client';
import { gql } from '@apollo/client';

const client = new ApolloClient({
  uri: '/data-api/graphql',
  cache: new InMemoryCache(),
});

const GET_SESSIONS = gql`
  query GetSessions{
  sessions {
    items {
      id
      title
      abstract
      speaker {
        id
        fullname
      }
    }
  }
}
`;

export async function getSessions() {
  const { data }  = await client.query({query:GET_SESSIONS});

  return data.sessions.items;
}

export async function getSessionsCount() {
  const response = await fetch("/data-api/rest/GetSessionsCount");
  if (!response.ok) return 'n/a';
  const data = await response.json();
  const totalCount = (data) ? data.value[0].total_session_count : "n/a";
  return totalCount;
}
