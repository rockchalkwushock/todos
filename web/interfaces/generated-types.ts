/* eslint-disable */
// DO NOT EDIT THIS FILE
// Generated by @graphql-codegen/cli using:
// (npm|yarn|pnpm) run generate
export type Maybe<T> = T | null
export type InputMaybe<T> = Maybe<T>
export type Exact<T extends { [key: string]: unknown }> = {
  [K in keyof T]: T[K]
}
export type MakeOptional<T, K extends keyof T> = Omit<T, K> & {
  [SubKey in K]?: Maybe<T[SubKey]>
}
export type MakeMaybe<T, K extends keyof T> = Omit<T, K> & {
  [SubKey in K]: Maybe<T[SubKey]>
}
// Generated on 23.08.2022 10:29

/** All built-in and custom scalars, mapped to their actual values */
export type Scalars = {
  ID: string
  String: string
  Boolean: boolean
  Int: number
  Float: number
  /**
   * The `DateTime` scalar type represents a date and time in the UTC
   * timezone. The DateTime appears in a JSON response as an ISO8601 formatted
   * string, including UTC timezone ("Z"). The parsed date and time string will
   * be converted to UTC if there is an offset.
   */
  DateTime: string
}

/** Inputs for Adding a Todo. */
export type AddTodoInputs = {
  description: InputMaybe<Scalars['String']>
  endDate: Scalars['DateTime']
  name: Scalars['String']
  startDate: Scalars['DateTime']
}

/** Mutation ErrorType */
export type ErrorType = {
  __typename: 'ErrorType'
  /** Field in which error occurred on. */
  field: Scalars['String']
  /** Validation error message for corresponding field. */
  message: Scalars['String']
}

export type RootMutationType = {
  __typename: 'RootMutationType'
  /** Add Todo. */
  addTodo: TodoPayload
}

export type RootMutationTypeAddTodoArgs = {
  inputs: AddTodoInputs
}

export type RootQueryType = {
  __typename: 'RootQueryType'
  /** Get a todo. */
  todo: Maybe<Todo>
  /** Get all todos. */
  todos: Array<Maybe<Todo>>
}

export type RootQueryTypeTodoArgs = {
  id: Scalars['ID']
}

/** Todo */
export type Todo = {
  __typename: 'Todo'
  /** Date todo was archived. */
  archivedAt: Maybe<Scalars['DateTime']>
  /** Date todo was created. */
  createdAt: Scalars['DateTime']
  /** Date todo was deleted. */
  deletedAt: Maybe<Scalars['DateTime']>
  /** Description of todo. */
  description: Maybe<Scalars['String']>
  /** Date todo is set to end. */
  endDate: Scalars['DateTime']
  id: Scalars['ID']
  /** Date todo was last modified. */
  modifiedAt: Scalars['DateTime']
  /** Name of todo. */
  name: Scalars['String']
  /** Date todo is set to start. */
  startDate: Scalars['DateTime']
  /** Status of todo. */
  status: TodoStatus
}

/** Todo Payload. */
export type TodoPayload = {
  __typename: 'TodoPayload'
  data: Maybe<Todo>
  errors: Maybe<Array<ErrorType>>
}

/** Status of a Todo */
export enum TodoStatus {
  /** Archived State */
  Archived = 'ARCHIVED',
  /** Finished State */
  Finished = 'FINISHED',
  /** In-Progress State */
  InProgress = 'IN_PROGRESS',
  /** Unstarted State */
  Unstarted = 'UNSTARTED',
}

export type AddTodoVariables = Exact<{
  inputs: AddTodoInputs
}>

export type AddTodo = {
  result: {
    __typename: 'TodoPayload'
    data: {
      __typename: 'Todo'
      createdAt: string
      description: string | null
      endDate: string
      id: string
      modifiedAt: string
      name: string
      startDate: string
      status: TodoStatus
    } | null
    errors: Array<{
      __typename: 'ErrorType'
      field: string
      message: string
    }> | null
  }
}

export type GetTodoVariables = Exact<{
  id: Scalars['ID']
}>

export type GetTodo = {
  todo: {
    __typename: 'Todo'
    createdAt: string
    description: string | null
    endDate: string
    id: string
    modifiedAt: string
    name: string
    startDate: string
    status: TodoStatus
  } | null
}

export type ListTodosVariables = Exact<{ [key: string]: never }>

export type ListTodos = {
  todos: Array<{
    __typename: 'Todo'
    createdAt: string
    description: string | null
    endDate: string
    id: string
    modifiedAt: string
    name: string
    startDate: string
    status: TodoStatus
  } | null>
}
