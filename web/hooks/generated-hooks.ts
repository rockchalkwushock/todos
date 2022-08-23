/* eslint-disable */
// DO NOT EDIT THIS FILE
// Generated by @graphql-codegen/cli using:
// (npm|yarn|pnpm) run generate
import * as T from '@interfaces/generated-types'
import {
  useMutation,
  useQuery,
  UseMutationOptions,
  UseQueryOptions,
} from '@tanstack/react-query'
import { fetcher } from '@services/data'
// Generated on 23.08.2022 10:29

export const AddTodoDocument = `
    mutation AddTodo($inputs: AddTodoInputs!) {
  result: addTodo(inputs: $inputs) {
    data {
      createdAt
      description
      endDate
      id
      modifiedAt
      name
      startDate
      status
    }
    errors {
      field
      message
    }
  }
}
    `
export const useAddTodo = <TError = T.ErrorType, TContext = unknown>(
  options?: UseMutationOptions<T.AddTodo, TError, T.AddTodoVariables, TContext>
) =>
  useMutation<T.AddTodo, TError, T.AddTodoVariables, TContext>(
    ['AddTodo'],
    (variables?: T.AddTodoVariables) =>
      fetcher<T.AddTodo, T.AddTodoVariables>(AddTodoDocument, variables)(),
    options
  )
export const GetTodoDocument = `
    query GetTodo($id: ID!) {
  todo(id: $id) {
    createdAt
    description
    endDate
    id
    modifiedAt
    name
    startDate
    status
  }
}
    `
export const useGetTodo = <TData = T.GetTodo, TError = T.ErrorType>(
  variables: T.GetTodoVariables,
  options?: UseQueryOptions<T.GetTodo, TError, TData>
) =>
  useQuery<T.GetTodo, TError, TData>(
    ['GetTodo', variables],
    fetcher<T.GetTodo, T.GetTodoVariables>(GetTodoDocument, variables),
    options
  )
export const ListTodosDocument = `
    query ListTodos {
  todos {
    createdAt
    description
    endDate
    id
    modifiedAt
    name
    startDate
    status
  }
}
    `
export const useListTodos = <TData = T.ListTodos, TError = T.ErrorType>(
  variables?: T.ListTodosVariables,
  options?: UseQueryOptions<T.ListTodos, TError, TData>
) =>
  useQuery<T.ListTodos, TError, TData>(
    variables === undefined ? ['ListTodos'] : ['ListTodos', variables],
    fetcher<T.ListTodos, T.ListTodosVariables>(ListTodosDocument, variables),
    options
  )
